unsetopt PROMPT_SUBST
precmd() {
    local c
    [[ -z $http_proxy$https_proxy ]] && c='#c170b7' || c='#D55F6F'
    PROMPT="%k%F{${c}} ❯ %k%f"
}
