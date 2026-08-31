// Cursor smear inspired by sphamba/smear-cursor.nvim.
// Ghostty gives us the current and previous cursor rectangles, so the four
// corners can be animated independently to create the same stretched shape.

const float LEADING_DURATION = 0.045;
const float SIDE_DURATION = 0.11;
const float TRAILING_DURATION = 0.24;
const float TRAIL_DURATION = 0.28;
const float MAX_TRAIL_CELLS = 25.0;
const float MIN_MOVE_PIXELS = 0.5;
const float EDGE_SOFTNESS = 1.0;
const float TAIL_OPACITY = 0.28;
const float GRADIENT_EXPONENT = 1.0;

float cross2(vec2 a, vec2 b) {
    return a.x * b.y - a.y * b.x;
}

float distanceToSegment(vec2 p, vec2 a, vec2 b) {
    vec2 ab = b - a;
    float denominator = max(dot(ab, ab), 0.0001);
    float projection = clamp(dot(p - a, ab) / denominator, 0.0, 1.0);
    return distance(p, a + ab * projection);
}

float signedRectangle(vec2 p, vec2 center, vec2 halfSize) {
    vec2 d = abs(p - center) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Signed distance for a clockwise convex quadrilateral.
float signedQuad(vec2 p, vec2 a, vec2 b, vec2 c, vec2 d) {
    float edgeDistance = min(
        min(distanceToSegment(p, a, b), distanceToSegment(p, b, c)),
        min(distanceToSegment(p, c, d), distanceToSegment(p, d, a))
    );

    float edge0 = cross2(b - a, p - a);
    float edge1 = cross2(c - b, p - b);
    float edge2 = cross2(d - c, p - c);
    float edge3 = cross2(a - d, p - d);
    float outside = max(max(edge0, edge1), max(edge2, edge3));
    float inside = step(outside, 0.0);

    return mix(edgeDistance, -edgeDistance, inside);
}

// A critically damped spring response, normalized to reach exactly 1 at t=1.
float springEase(float t) {
    t = clamp(t, 0.0, 1.0);
    float response = 1.0 - exp(-8.0 * t) * (1.0 + 8.0 * t);
    float endResponse = 1.0 - exp(-8.0) * 9.0;
    return clamp(response / endResponse, 0.0, 1.0);
}

float durationForCorner(vec2 cornerDirection, vec2 movementDirection) {
    float alignment = dot(cornerDirection, movementDirection);
    if (alignment >= 0.0) {
        return mix(SIDE_DURATION, LEADING_DURATION, alignment);
    }
    return mix(SIDE_DURATION, TRAILING_DURATION, -alignment);
}

float progressForCorner(float elapsed, float duration) {
    return springEase(elapsed / duration);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord / iResolution.xy);

    if (iCursorVisible == 0 || iFocus == 0) return;
    if (iCurrentCursorStyle == CURSORSTYLE_BLOCK_HOLLOW ||
        iCurrentCursorStyle == CURSORSTYLE_LOCK) return;
    if (iCurrentCursorColor.a <= 0.001) return;

    vec2 currentSize = iCurrentCursor.zw;
    vec2 previousSize = iPreviousCursor.zw;
    if (currentSize.x <= 0.0 || currentSize.y <= 0.0 ||
        previousSize.x <= 0.0 || previousSize.y <= 0.0) return;

    vec2 currentCenter = iCurrentCursor.xy + currentSize * vec2(0.5, -0.5);
    vec2 previousCenter = iPreviousCursor.xy + previousSize * vec2(0.5, -0.5);
    vec2 movement = currentCenter - previousCenter;
    float movementLength = length(movement);
    if (movementLength <= MIN_MOVE_PIXELS) return;

    float maxTrailDistance = MAX_TRAIL_CELLS * max(currentSize.x, currentSize.y);
    vec2 previousOffset = vec2(0.0);
    if (movementLength > maxTrailDistance) {
        vec2 limitedMovement = movement * (maxTrailDistance / movementLength);
        previousOffset = currentCenter - limitedMovement - previousCenter;
        movement = limitedMovement;
        movementLength = maxTrailDistance;
    }

    float elapsed = max(iTime - iTimeCursorChange, 0.0);
    if (elapsed >= TRAIL_DURATION) return;

    vec2 movementDirection = movement / movementLength;
    vec2 currentTopLeft = iCurrentCursor.xy;
    vec2 currentTopRight = currentTopLeft + vec2(currentSize.x, 0.0);
    vec2 currentBottomRight = currentTopLeft + vec2(currentSize.x, -currentSize.y);
    vec2 currentBottomLeft = currentTopLeft + vec2(0.0, -currentSize.y);

    vec2 previousTopLeft = iPreviousCursor.xy + previousOffset;
    vec2 previousTopRight = previousTopLeft + vec2(previousSize.x, 0.0);
    vec2 previousBottomRight = previousTopLeft + vec2(previousSize.x, -previousSize.y);
    vec2 previousBottomLeft = previousTopLeft + vec2(0.0, -previousSize.y);

    const float inverseSqrtTwo = 0.70710678;
    vec2 topLeftDirection = vec2(-inverseSqrtTwo, inverseSqrtTwo);
    vec2 topRightDirection = vec2(inverseSqrtTwo, inverseSqrtTwo);
    vec2 bottomRightDirection = vec2(inverseSqrtTwo, -inverseSqrtTwo);
    vec2 bottomLeftDirection = vec2(-inverseSqrtTwo, -inverseSqrtTwo);

    vec2 smearTopLeft = mix(
        previousTopLeft,
        currentTopLeft,
        progressForCorner(elapsed, durationForCorner(topLeftDirection, movementDirection))
    );
    vec2 smearTopRight = mix(
        previousTopRight,
        currentTopRight,
        progressForCorner(elapsed, durationForCorner(topRightDirection, movementDirection))
    );
    vec2 smearBottomRight = mix(
        previousBottomRight,
        currentBottomRight,
        progressForCorner(elapsed, durationForCorner(bottomRightDirection, movementDirection))
    );
    vec2 smearBottomLeft = mix(
        previousBottomLeft,
        currentBottomLeft,
        progressForCorner(elapsed, durationForCorner(bottomLeftDirection, movementDirection))
    );

    float smearDistance = signedQuad(
        fragCoord,
        smearTopLeft,
        smearTopRight,
        smearBottomRight,
        smearBottomLeft
    );
    float smearAlpha = 1.0 - smoothstep(-EDGE_SOFTNESS, EDGE_SOFTNESS, smearDistance);

    // Leave the actual Ghostty cursor untouched at the destination.
    float currentDistance = signedRectangle(fragCoord, currentCenter, currentSize * 0.5);
    float outsideCurrentCursor = smoothstep(0.0, EDGE_SOFTNESS, currentDistance);

    float movementLengthSquared = max(dot(movement, movement), 0.0001);
    float trailPosition = clamp(
        dot(fragCoord - (currentCenter - movement), movement) / movementLengthSquared,
        0.0,
        1.0
    );
    float gradient = mix(TAIL_OPACITY, 1.0, pow(trailPosition, GRADIENT_EXPONENT));
    float timeFade = 1.0 - smoothstep(TRAIL_DURATION * 0.75, TRAIL_DURATION, elapsed);
    float trailAlpha = smearAlpha * outsideCurrentCursor * gradient * timeFade;
    trailAlpha = clamp(trailAlpha * iCurrentCursorColor.a, 0.0, 1.0);

    // iChannel0 is premultiplied. Composite the trail as a real layer so it
    // remains visible over transparent macOS glass without flattening the rest
    // of the terminal.
    vec4 trail = vec4(iCurrentCursorColor.rgb * trailAlpha, trailAlpha);
    fragColor = trail + fragColor * (1.0 - trailAlpha);
}
