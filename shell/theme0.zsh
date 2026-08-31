unsetopt PROMPT_SUBST
precmd() {
    local c
    [[ -z $http_proxy$https_proxy ]] && c='#686eaa' || c='#D55F6F'
    PROMPT="%k%F{${c}} ❯ %k%f"
}
