local wezterm = require("wezterm")
local act = wezterm.action

local font_list = {'SauceCodePro NFM', '霞鹜文楷等宽' , 'Segoe UI Emoji'} --霞鹜文楷等宽|Maple Mono NF CN

local msys = "C:/msys64/msys2_shell.cmd"
local opacity = 0.95
local fontsize = 15

local nf = wezterm.nerdfonts
local function nerdfont_icon(input)
    if input == nil then
        return nf.ple_right_half_circle_thick, ' '.. nf.ple_left_half_circle_thick
    end
    if input == 0 then
        return nf.ple_upper_left_triangle, nf.ple_lower_right_triangle
    elseif input == 1 then
        return nf.ple_lower_left_triangle, nf.ple_upper_right_triangle
    end
end
local SOLID_RIGHT_ARROW, SOLID_LEFT_ARROW = nerdfont_icon() -- 0|1

local colors = {
    default   = { bg = '#494c62', fg = '#111119' },
    is_active = { bg = '#6a6e8e', fg = '#111119' },
    hover     = { bg = '#6a6e8e', fg = '#111119' },
    zoom      = { bg = '#6a6e8e', fg = '#111119' }
}

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "Wezterm"
end)
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = "#2A3441"
    local bg, fg, attr
    if tab.is_active then
        attr = { Italic = true } bg = colors.is_active.bg fg = colors.is_active.fg
    elseif hover then
        bg = colors.hover.bg fg = colors.hover.fg attr = { Intensity = "Normal" }
    else
        bg = colors.default.bg fg = colors.default.fg attr = { Intensity = "Normal" }
    end

    local edge_foreground = bg
    local process_name = basename(tab.active_pane.foreground_process_name):gsub("%.exe$", "")
    local title
    if process_name:len() > 0 then
        if process_name:len() > 6 then
            title = process_name:sub(1, 5) .. "…"
        else
            title = process_name .. string.rep(" ", 6 - process_name:len())
        end
    else
        title = "     "
    end

    local left_arrow, left_bg, left_fg
    if tab.tab_index == 0 then
        left_arrow = " "
        left_bg = bg
        left_fg = bg
    else
        left_arrow = SOLID_LEFT_ARROW
        left_bg = edge_background
        left_fg = edge_foreground
    end

    if tab.active_pane.is_zoomed and tab.is_active then
        bg = colors.zoom.bg
        fg = colors.zoom.fg
        attr = { Intensity = 'Bold' }
    end

    local title_text = " " .. title .. " "
    return {
        { Attribute = attr },
        { Background = { Color = left_bg } },
        { Foreground = { Color = left_fg } },
        { Text = left_arrow },

        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = title_text },

        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = SOLID_RIGHT_ARROW },
    }
end)

local config = {
    --exit_behavior='Hold',
    audible_bell="Disabled",
    window_close_confirmation = "NeverPrompt", --不用确认关闭
    enable_tab_bar = true, --是否隐藏bar
    hide_tab_bar_if_only_one_tab = false,--只有一个tabs是否隐藏
    use_fancy_tab_bar = false, --是否使用系统原始标签页
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    enable_scroll_bar = false, --不显示滚动条
    initial_rows = 24,
    initial_cols = 80,

    --[[ color_scheme = "catppuccin-frappe", ]]
    colors = {
        tab_bar = {
            background    =             "#2A3441",
            new_tab       = {bg_color = "#2A3441", fg_color = "#494c62", intensity = "Bold"},
            new_tab_hover = {bg_color = "#2A3441", fg_color = "#6a6e8e", intensity = "Bold"},
            --[[ active_tab    = {bg_color = "#2A3441", fg_color = "#FCE8C3"}, ]]
        },
        cursor_bg     = "#626880",
        cursor_border = "#626880",
        cursor_fg     = "#c6d0f5",

        selection_bg  = "#414559",
        selection_fg  = "#c6d0f5",
        foreground    = "#c6d0f5",
        background    = "#303446",
        
        ansi    = {"#51576d","#e78284","#a6d189","#e5c890","#8caaee","#f4b8e4","#81c8be","#a5adce"},
        brights = {"#626880","#e67172","#8ec772","#d9ba73","#7b9ef0","#f2a4db","#5abfb5","#b5bfe2"},
        --split = '#444444',

        --copy_mode_inactive_highlight_bg = { Color = '#626880' },未选中颜色
        --copy_mode_inactive_highlight_fg = { Color = '#ffffff' },
        --copy_mode_active_highlight_bg = { Color = '#ff6a19' },
        --copy_mode_active_highlight_fg = { Color = '#ffffff' }
    },

    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, --窗口边距
    integrated_title_button_alignment ="Right",
    integrated_title_button_color = "Auto",
    integrated_title_button_style = "Windows",
    integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },

    window_background_opacity = opacity,
    front_end = "WebGpu", -- OpenGL|WebGpu|Software
    --webgpu_power_preference = "LowPower" -- 'HighPerformance'|'LowPower'

    --freetype_load_flags = 'NO_HINTING|MONOCHROME',
    freetype_load_target = "Light", -- 'HorizontalLcd'|'Normal'|'VerticalLcd'|'Mono'
    freetype_render_target = "Normal", --HorizontalLcd Normal 

    adjust_window_size_when_changing_font_size = false,
    hide_mouse_cursor_when_typing=true,
    custom_block_glyphs = false, --控制nerd font符号

    -- font = wezterm.font(fonts, { weight = "Regular", stretch = "Normal", style = "Normal" }),
    font = wezterm.font_with_fallback(font_list, { weight = "Regular", style = 'Normal', italic = false}),
    font_rules = {
        {
            intensity = 'Normal', italic = true,
            font = wezterm.font_with_fallback(font_list , {weight= 'Regular',style='Italic', italic = true, }),
        },
        {
            intensity = 'Bold', italic = false,
            font = wezterm.font_with_fallback(font_list, { weight = 'Bold',style = 'Normal', italic = false}),
        },
        {
            intensity = 'Bold', italic = true,
            font = wezterm.font_with_fallback(font_list, { weight = 'Bold',style = 'Italic', italic = true }),
        },
    },

    font_size = fontsize,

    keys = {
        { key = 'v', mods = 'ALT',        action = act.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'ALT',        action = act.CopyTo 'Clipboard'},
        { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard'},

        { key = 'z', mods = 'SHIFT|ALT', action = act.DecreaseFontSize },
        { key = 'a', mods = 'SHIFT|ALT', action = act.IncreaseFontSize },
        { key = 'r', mods = 'SHIFT|ALT', action = act.ResetFontSize },

        { key = 'u', mods = 'SHIFT|ALT', action  = act.ScrollByLine(-1) },
        { key = 'd', mods = 'SHIFT|ALT', action  = act.ScrollByLine(1) },
        { key = 'u', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-0.5) },
        { key = 'd', mods = 'SHIFT|CTRL', action = act.ScrollByPage(0.5) },

        --{ key = 'f', mods = 'ALT',action = act.Search {Regex = '[a-f0-9]{6,}',},},
        --{ key = 'f', mods = 'ALT',action = act.Search { CaseSensitiveString = 'hash' },},
        { key = 'f', mods = 'SHIFT|ALT', action = act.Search { CaseInSensitiveString = '' },},
        { key = 'g', mods = 'SHIFT|ALT', action = act.ActivateCopyMode },

        { key = 'w', mods = 'SHIFT|ALT', action = act.CloseCurrentTab { confirm = false }, },
        { key = 'c', mods = 'SHIFT|ALT', action = act.CloseCurrentPane { confirm = false },},

        { key = 'v', mods = 'SHIFT|ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },},
        { key = 's', mods = 'SHIFT|ALT', action = act.SplitVertical},
        { key = 'm', mods = 'SHIFT|ALT', action = act.TogglePaneZoomState,},

        { key = 'o', mods = 'SHIFT|ALT', action = act.SpawnTab 'CurrentPaneDomain',},
        { key = 'p', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(-1) },
        { key = 'n', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(1) },

        { key = 'h', mods = 'SHIFT|ALT', action = act.ActivatePaneDirection 'Left',},
        { key = 'l', mods = 'SHIFT|ALT', action = act.ActivatePaneDirection 'Right',},
        { key = 'k', mods = 'SHIFT|ALT', action = act.ActivatePaneDirection 'Up',},
        { key = 'j', mods = 'SHIFT|ALT', action = act.ActivatePaneDirection 'Down',},

        { key = 'h', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Left', 5 },},
        { key = 'j', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Down', 5 },},
        { key = 'k', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'l', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Right', 5 },},
        { key = 'p', mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs{flags='LAUNCH_MENU_ITEMS'}},
        --{ key = 'a', mods = 'CTRL',       action = act.SendString '\x3a\x78\x0a' }, -- :x<cr>
        {
            key = 'x', mods = 'SHIFT|ALT',
            action = wezterm.action_callback(function(win, pane)
                local tab = win:active_tab()
                for i = #tab:panes(), 1, -1 do -- 反向遍历避免动态修改问题
                    local p = tab:panes()[i]
                    if p:pane_id() ~= pane:pane_id() then
                        p:activate()
                        win:perform_action(act.CloseCurrentPane{confirm = false}, p)
                    end
                end
            end),
        },
        {
            key = "q", mods = "SHIFT|ALT",
            action = wezterm.action_callback(function(win, _)
                local current_tab = win:active_tab()
                for _, tab in ipairs(win:mux_window():tabs()) do
                    if tab:tab_id() ~= current_tab:tab_id() then
                        tab:activate()
                        local panes = tab:panes()
                        if #panes > 0 then
                            for i = #panes, 1, -1 do
                                win:perform_action(
                                    act.CloseCurrentPane({ confirm = false }),
                                    panes[i]
                                )
                            end
                        else
                            win:perform_action(
                                act.CloseCurrentTab({ confirm = false }),
                                tab:active_pane() or win:active_pane()
                            )
                        end
                    end
                end
            end),
        },
    },
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
    config.default_cwd = "D:/"
    config.launch_menu = {
        { label = "Pwsh", args = {'pwsh.exe', '-NoLogo', '-NoLogo'}, },
        { label = 'Ucrt64', args = { msys, '-defterm', '-here', '-no-start', '-ucrt64', '-shell', 'zsh'}},
        --[[ { label = 'Wsl', args = {'wsl', '--cd', '~'} }, ]]
        --[[ { label = 'Tmux', args = {'wsl.exe', '--cd', '~', '--exec', 'tmux'} }, ]]
        { label = 'Powershell', args = { 'powershell.exe' } },
        { label = 'Nushell', args = { 'nu.exe' } },
        { label = 'Mingw64', args = { msys, '-defterm', '-here', '-no-start', '-mingw64','-shell','zsh'}},
    }
    config.win32_system_backdrop = 'Acrylic' --Mica Acrylic Tabbed Auto Disable
else
    --Linux for Macos
    config.default_prog = { 'zsh', '-l' }
    config.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Nushell', args = { 'nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
    }
end
return config
