typeset -g FORMATTED_PATH=""
typeset -g PROXY_STATUS=""
function chpwd1() {
    local current_path=${PWD/#$HOME/\~}
    local segments=(${(s:/:)current_path})

    if (( ${#segments[@]} <= 3 )); then
        FORMATTED_PATH=$current_path
    else
        FORMATTED_PATH="…/${segments[-2]}/${segments[-1]}"
    fi
}
function chpwd() {
    local path=$PWD
    local rel_home=false
    if [[ $path == $HOME* ]]; then
        rel_home=true
        path=${path/#$HOME/}
        path=${path/#\//}
    fi
    local segments=(${(s:/:)path})
    local len=${#segments[@]}
    local second_last="" last=""
    if (( len >= 2 )); then
        second_last=${segments[-2]}
        last=${segments[-1]}
    elif (( len == 1 )); then
        last=${segments[-1]}
    fi
    if [[ -n $second_last && ${#second_last} -gt 5 ]]; then
        second_last="${second_last[1,4]}…"
    fi

    if $rel_home && (( len <= 2 )); then
        if [[ -n $second_last ]]; then
            FORMATTED_PATH="~/${second_last}/${last}"
        elif [[ -n $last ]]; then
            FORMATTED_PATH="~/${last}"
        else
            FORMATTED_PATH="~"
        fi
    else
        if [[ -n $second_last ]]; then
            FORMATTED_PATH="…/${second_last}/${last}"
        else
            FORMATTED_PATH="…/${last}"
        fi
    fi
}
function precmd() {
    [[ -z $http_proxy && -z $https_proxy ]] && PROXY_STATUS="" || PROXY_STATUS=""
}
chpwd
precmd

#theme1='%K{#749395}%F{#A0819D}%F{#749395}%K{#7F81AF}'
theme1='%K{#749395}%F{#A0819D}%F{#7F81AF}%K{#749395}' #  
#theme1='%K{#A0819D}%F{#749395}%F{#749395}%K{#7F81AF}'
right1='%k%F{NONE}%F{#7F81AF}%k%f'
setopt PROMPT_SUBST
PROMPT='%F{#414559}%K{#A0819D} ${FORMATTED_PATH} ${theme1}%K{#7F81AF}%F{#414559} ${PROXY_STATUS} ${right1} '
#PROMPT='%F{#414559}%K{#A0819D} ${FORMATTED_PATH} ${theme1}%K{#7F81AF}%F{#414559} ${PROXY_STATUS} ${right1}
#%F{#749395} ❯%f '
