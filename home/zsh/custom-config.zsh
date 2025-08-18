# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
precmd() { echo -ne '\e[5 q' ;}

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}''${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

# git-safer uses autocomplete of git
compdef git-safer=git
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char
# Rebinding clear key
bindkey -s '^l' 'clear\n'
# Rebind HOME and END 
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
# To discover what keycode is being sent, hit ^v
# and then the key you want to test.
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
# Rebind DEL, PGDN and insert
bindkey '\e[3~' delete-char
bindkey '^[[P' delete-char
bindkey '\e[6~' end-of-history
bindkey '\e[2~' redisplay
# Custom bindings
bindkey -s "^f" "tmux-smug\n"
