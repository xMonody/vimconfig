cat theme3.zsh
typeset -g FORMATTED_PATH=""
typeset -g PROXY_STATUS=""

function chpwd() {
    local path=$PWD
    local rel_home=false

    if [[ $path == $HOME* ]]; then
        rel_home=true
        path=${path/#$HOME/}
        path=${path#/}
    fi

    local -a segments
    segments=(${(s:/:)path})
    local len=${#segments[@]}

    if (( len == 0 )); then
        FORMATTED_PATH="~"
        return
    fi

    local -a tail
    if (( len <= 3 )); then
        tail=("${segments[@]}")
    else
        tail=("${segments[-3]}" "${segments[-2]}" "${segments[-1]}")
    fi

    local joined="${(j:/:)tail}"

    if $rel_home; then
        if (( len <= 3 )); then
            FORMATTED_PATH="~/${joined}"
        else
            FORMATTED_PATH="…/${joined}"
        fi
    else
        if (( len <= 3 )); then
            FORMATTED_PATH="/${joined}"
        else
            FORMATTED_PATH="…/${joined}"
        fi
    fi
}

function precmd() {
    [[ -z $http_proxy && -z $https_proxy ]] && PROXY_STATUS="#7C73B0" || PROXY_STATUS="#d55f6f"
}

chpwd
precmd

setopt PROMPT_SUBST
PROMPT=' %F{#317272} %F{#7C73B0}${FORMATTED_PATH}
%F{${PROXY_STATUS}} ❯%f '
