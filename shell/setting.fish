
# ------- Fish shell config

alias bat='bat --style="header" --paging=never --theme=TwoDark'
alias lg lazygit
alias cls reset
alias sfish 'exec fish'
alias szsh 'exec zsh'

set -x EDITOR 'vim -U NONE'
set -x VISUAL 'vim -U NONE'

set -x FZF_DEFAULT_OPTS "--border=rounded --preview 'bat --style=numbers --color=always {}' \
--preview-window=right:60%:border-left --color=border:#565f89,pointer:#7C73B0,\
current-bg:#585d73,current-fg:-1:regular"
set -x FZF_CTRL_R_OPTS "--preview-window=hidden --color=border:#565f89,\
pointer:#7C73B0,current-bg:#585d73,current-fg:-1:regular"

set cxstdmodules "clang++ -std=c++23 -stdlib=libc++ --precompile -Wno-reserved-identifier \
-Wno-reserved-module-identifier (fd std.cppm /usr) -o std.pcm "
abbr --add gstdmodules 'g++ -std=c++23 -fmodules -c -fmodule-only -fsearch-include-path bits/std.cc'
abbr --add gmodules 'g++ -std=c++23 -fmodules '
abbr --add cstdmodules $cxstdmodules
abbr --add cmodules 'clang++ -std=c++23 -stdlib=libc++ -fmodule-file=std=std.pcm std.pcm '
#clang -x c++-header -emit-pch -o xxx.h.pch
#clang main.c++ -include-pch xxx.h.pch -o
#gcc -x c-header -c -o xxx.h.gch
#g++ -x c++-header -o xxx.hpp.gch

abbr --add tgz 'tar -tzvf '
abbr --add txz 'tar -tJvf '
abbr --add tbz 'tar -tjvf '
abbr --add tzst 'tar --zstd -tvf '
abbr --add t7z '7z l '
abbr --add tzip 'unzip -l'

abbr --add xgz 'tar -xzvf '
abbr --add xxz 'tar -xJvf '
abbr --add xbz 'tar -xjvf '
abbr --add xzst 'tar --zstd -xvf '
abbr --add x7z '7z x '
abbr --add xzip 'unzip '

set fish_color_normal           white
set fish_color_comment          black   # comment
set fish_color_valid_path       white   # path
set fish_color_command          yellow  # d5855a 2E8B57  # 008267 009374
set fish_color_keyword          4683C1  # if, else, for
set fish_color_end	            white   #  |, ;, &, &&
set fish_color_option           white   #  option
set fish_color_param            white   # set param
set fish_color_autosuggestion   black   #  autosuggestion
set fish_color_error            red     # error
set fish_color_cancel           red     # ctrl-c
set fish_color_redirection      white   # 重定向符号 >, >>, <, 2>
set fish_color_search_match     green
set fish_color_operator	        B766AD  #  =, ~, ? $variable
set fish_color_quote	        676E95  # 字符串颜色 "...",'...'
set fish_pager_color_completion white   # tab option

function my_cancel_commandline
    #if test -z "$(commandline)"
        #commandline -f repaint
        #else
        commandline -f cancel-commandline
        #end
end
bind \cc my_cancel_commandline

function format_path
    set -l current_path (string replace $HOME '~' $PWD)
    set -l segments (string split '/' $current_path)
    set -l count (count $segments)

    if test $count -le 2
        echo $current_path
    else
        echo "…/"(string join '/' $segments[-2] $segments[-1])
    end
end

function proxystatus
    if not set -q http_proxy; and not set -q https_proxy
        printf ""
    else
        printf ""
    end
end


if status is-interactive
    printf "\x1b[2 q"
    set fish_greeting      ""          # 取消欢迎提示
    #function fish_mode_prompt          # 取消vi模式显示
    #end
    function fish_prompt
        if not set -q _prompt_colors_cached
            set -g _fg1 (set_color    414559)
            set -g _bg1 (set_color -b A0819D)
            set -g _fg2 (set_color    A0819D)
            set -g _bg2 (set_color -b 749395)
            set -g _fg3 (set_color    749395)
            set -g _bg3 (set_color -b 7F81AF)
            set -g _fg4 (set_color    7F81AF)
            set -g _sep1 (string join '' $_bg2 $_fg2 "")
            set -g _sep2 (string join '' $_bg2 $_fg4 "")
            #set -g _sep1 (string join '' $_bg2 $_fg2 "")
            #set -g _sep2 (string join '' $_bg3 $_fg3 "")
            #set -g _sep1 (string join '' $_bg1 $_fg3 "")
            #set -g _sep2 (string join '' $_bg3 $_fg3 "")
            set -g _edge (string join '' $_bg3 $_fg3 ' ' (set_color -b normal) (set_color 7F81AF) "")
            set -g _reset (set_color normal)
            set -g _prompt_colors_cached 1
        end
        set -l path (format_path)
        set -l proxy (proxystatus)
        printf "\n%s%s %s %s%s%s%s%s %s%s%s%s " \
        $_fg1 $_bg1 "$path" $_reset $_sep1 $_sep2 $_bg3 $_fg1 "$proxy" $_edge $_reset
        #echo
        #echo -n "$_fg1$_bg1 $path $_reset$_sep1$_sep2$_bg3$_fg1 $proxy$_edge$_reset "
    end
end

function toggle_proxy
    set -l default_ip "127.0.0.1"
    set -l port "10809"

    set -l custom_ip $argv[1]
    if test -z "$custom_ip"
        set -l target_ip "http://$default_ip:$port"
        if not set -q http_proxy; and not set -q https_proxy
            set -gx HTTP_PROXY $target_ip
            set -gx HTTPS_PROXY $target_ip
            set -gx http_proxy $target_ip
            set -gx https_proxy $target_ip
        else
            set -e HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
        end
    else
        set -l target_ip "http://192.168.$custom_ip:$port"
        set -gx HTTP_PROXY $target_ip
        set -gx HTTPS_PROXY $target_ip
        set -gx http_proxy $target_ip
        set -gx https_proxy $target_ip
    end
end
alias proxy toggle_proxy
