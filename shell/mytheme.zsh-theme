function format_path {
    local current_path=${PWD/#$HOME/\~}
    local segments=(${(s:/:)current_path})
    local count=${#segments[@]}
    if (( count <= 2 )); then
        echo "$current_path"
    else
        echo "…/${segments[-2]}/${segments[-1]}"
    fi
}

function proxystatus {
  if [[ -z $http_proxy && -z $https_proxy ]]; then
      echo ""
  else
      echo ""
  fi
}
# #A0819D #7F81AF #749395
# #df9aba #9d9adf #87beaa

PROMPT="%F{#414559}%K{#A0819D}
 $(format_path) %K{#749395}%F{#A0819D}%F{#749395}%K{#7F81AF}%K{#7F81AF}%F{#A0819D} $(proxystatus) %K{NONE}%F{#7F81AF}%k%f "

