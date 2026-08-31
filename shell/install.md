
# install prezto
```bash
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
## .zpreztorc config
```bash
zstyle ':prezto:load' pmodule \
  'environment' \
  'spectrum' \
  'terminal' \
  'history' \
  'command-not-found' \
  'history-substring-search' \
  'completion' \
  'syntax-highlighting' \
  'autosuggestions'

# zstyle ':prezto:module:history-substring-search' color 'no'
zstyle ':prezto:module:history-substring-search:color' found 'fg=green'
```
# zimfw install
```bash
wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

## .zimfw config
```bash
zmodule environment
zmodule input
zmodule termtitle
# zmodule utility
# zmodule asciiship
zmodule zsh-users/zsh-completions --fpath src
zmodule completion
zmodule zsh-users/zsh-history-substring-search
zmodule zsh-users/zsh-syntax-highlighting
zmodule zsh-users/zsh-autosuggestions

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green'
```
