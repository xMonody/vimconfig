
#export LC_ALL=C.UTF-8
#export LANG=C.UTF-8
echo -ne "\x1b[2 q" #  "\x1b[2 q\033]12;#7C73B0\0x7"
bindkey -e
unsetopt beep        # 禁用 zsh 内置的 beep
unsetopt hist_beep   # 禁用历史搜索时的 beep
unsetopt list_beep   # 禁用自动补全时的 beep

alias bat='bat --style="header" --paging=never --theme=TwoDark'
alias ls=lsd
alias ll="ls -all"
alias cls='reset'

export PATH=/d/Compile/Nodejs:/d/Edit/nvim/bin:~/.npmpath:$PATH
alias vim=nvim
export EDITOR='vim -u NONE'
export VISUAL='vim -u NONE'

function toggle_proxy {
    local default_ip="127.0.0.1"
    local port="10809"

    if [[ -n "$NATPROXY" ]]; then
        local gateway=$(ip route | grep default | awk '{print $3}')
        if [[ -n "$gateway" ]]; then
            default_ip="$gateway"
        fi
    fi

    local custom_ip="${1:-}"
    if [[ -z $custom_ip ]]; then
        local target_ip="http://$default_ip:$port"
        if [[ -z $http_proxy && -z $https_proxy ]]; then
            export HTTP_PROXY="$target_ip"
            export HTTPS_PROXY="$target_ip"
            export http_proxy="$target_ip"
            export https_proxy="$target_ip"
        else
            unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
        fi
    else
        local target_ip="http://192.168.$custom_ip:$port"
        export HTTP_PROXY="$target_ip"
        export HTTPS_PROXY="$target_ip"
        export http_proxy="$target_ip"
        export https_proxy="$target_ip"
    fi
}
alias proxy="toggle_proxy"

unsetopt PROMPT_SUBST
precmd() {
    local c
    [[ -z $http_proxy$https_proxy ]] && c='#B766AD' || c='#D55F6F'
    PROMPT="%k%F{${c}} ❯ %k%f"
}
