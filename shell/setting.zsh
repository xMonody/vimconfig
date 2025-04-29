
zle_highlight=('paste:none') # setting paste fg color 
echo -ne "\x1b[2 q" #  "\x1b[2 q\033]12;#7C73B0\0x7"
unsetopt beep        # 禁用 zsh 内置的 beep
unsetopt hist_beep   # 禁用历史搜索时的 beep
unsetopt list_beep   # 禁用自动补全时的 beep

alias bat='bat --style="header" --paging=never --theme=TwoDark'
alias lg=lazygit
alias cls='reset'
alias sfish='exec fish'
alias szsh='exec zsh'

export EDITOR='vim -u NONE'
export VISUAL='vim -u NONE'

export FZF_COMPLETION_TRIGGER=".."
export FZF_DEFAULT_OPTS=" --border=rounded --preview 'bat --style=numbers --color=always {}' \
--preview-window=right:60%:border-left --color=border:#565f89,pointer:#7C73B0,\
current-bg:#585d73,current-fg:-1:regular"
export FZF_CTRL_R_OPTS="--preview-window=hidden --color=border:#565f89,\
pointer:#7C73B0,current-bg:#585d73,current-fg:-1:regular"

cstdmodules="-Wno-reserved-module-identifier (fd std.cppm /usr) -o std.pcm"
typeset -A abbreviations #abbr 简写
abbreviations=(
    gstdmodules "g++ -std=c++23 -fmodules -c -fmodule-only -fsearch-include-path bits/std.cc"
    gmodules    "g++ -std=c++23 -fmodules "
    cstdmodules "clang++ -std=c++23 -stdlib=libc++ --precompile -Wno-reserved-identifier $cstdmodules"
    cmodules    "clang++ -std=c++23 -stdlib=libc++ -fmodule-file=std=std.pcm std.pcm "
    tgz 'tar -tzvf '
    txz 'tar -tJvf '
    tbz 'tar -tjvf '
    tzst 'tar --zstd -tvf '
    t7z '7z l '
    tzip 'unzip -l'
#clang -x c++-header -emit-pch -o xxx.h.pch 
#clang main.c++ -include-pch xxx.h.pch -o 
#gcc -x c-header -c -o xxx.h.gch
#g++ -x c++-header -o xxx.hpp.gch
    xgz 'tar -xzvf '
    xxz 'tar -xJvf '
    xbz 'tar -xjvf '
    xzst 'tar --zstd -xvf '
    x7z '7z x '
    xzip 'unzip '
)
expand-abbrev() {
    local word=${LBUFFER##*[[:space:]]}
    if [[ -n ${abbreviations[$word]} ]]; then
        LBUFFER="${LBUFFER%$word}${abbreviations[$word]}"
    fi
    zle .self-insert
}
zle -N expand-abbrev
bindkey ' ' expand-abbrev
bindkey '^[e' edit-command-line # 将 Alt+E 绑定到编辑命令行
# bindkey -r '^X^E' # 可选：如果不想保留原有的 Ctrl-X Ctrl-E

if [[ -n $ZSH_HIGHLIGHT_HIGHLIGHTERS ]]; then
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#B766AD' # $() =
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=white'  # ``
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=white'            # -arg
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=white'            # --arg
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=white'                # | ; &&
    ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=white'                   # path
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=white'                     # > >>
    ZSH_HIGHLIGHT_STYLES[default]='fg=white'                         # default
    ZSH_HIGHLIGHT_STYLES[path]='fg=white'                            # path
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=#008267'                    # sudo time exec
    ZSH_HIGHLIGHT_STYLES[command]='fg=#008267'                       # command
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#008267'                       # echo print type
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#008267'             # #2E8B57 #008267 #009374 yellow
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#B766AD' # " $args"
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#4683C1'                 # if for do done
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#676E95'        # 'string'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#676E95'        # "string"
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#676E95'          # ` xxx `
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'                     # error
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black'                       # autosuggest
    ZSH_HIGHLIGHT_STYLES[comment]='fg=black'                         # comment
fi

function toggle_proxy {
    local default_ip="127.0.0.1"
    local port="10809"

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

typeset -g FORMATTED_PATH=""
typeset -g PROXY_STATUS=""
function chpwd() {
    local current_path=${PWD/#$HOME/\~}
    local segments=(${(s:/:)current_path})

    if (( ${#segments[@]} <= 2 )); then
        FORMATTED_PATH=$current_path
    else
        FORMATTED_PATH="…/${segments[-2]}/${segments[-1]}"
    fi
}
function precmd() {
    [[ -z $http_proxy && -z $https_proxy ]] && PROXY_STATUS="" || PROXY_STATUS=""
}
chpwd
precmd

theme1='%K{#A0819D}%F{#749395}%F{#749395}%K{#7F81AF}'
#theme1='%K{#749395}%F{#A0819D}%F{#749395}%K{#7F81AF}'
#theme1='%K{#749395}%F{#A0819D}%F{#7F81AF}%K{#749395}'#

setopt PROMPT_SUBST
PROMPT='%F{#414559}%K{#A0819D}
 ${FORMATTED_PATH} ${theme1}%K{#7F81AF}%F{#414559} ${PROXY_STATUS} %K{NONE}%F{#7F81AF}%k%f '
