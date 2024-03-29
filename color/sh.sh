set_custom_prompt() {
    local dir=$(basename "$PWD")
    name="${dir##*/}"
    if [ "$dir" == "/" ]; then
        filename="/"
    elif [ "$dir" == $USER ]; then
        filename="~"
    else
        filename=$name
    fi

    #    
PS1="\[\e[38;2;60;59;54m\]\[\e[48;2;104;160;225m\]    \[\e[38;2;104;160;225m\]\[\e[48;2;60;59;54m\]\[\e[38;2;60;59;54m\]\[\e[48;2;73;85;106m\]\[\e[38;2;104;160;225m\]\[\e[48;2;73;85;106m\] $filename \[\e[38;2;73;85;106m\]\[\e[49m\]\[\e[0m\] "

}
PROMPT_COMMAND="set_custom_prompt"
