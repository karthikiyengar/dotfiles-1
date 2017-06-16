autoload -Uz compinit
compinit

# prompt setup
setopt PROMPT_SUBST
source ~/.local/shrink-path.plugin.zsh
PS1='%F{blue}$(shrink_path -f) %F{red}❯%F{green}❯%F{blue}❯%f%b '

# vi mode setup
bindkey -v
export KEYTIMEOUT=1
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%F{magenta}[% NORMAL]%"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# for bringing up editor on C-x C-e
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
bindkey -M viins '\e.' insert-last-word

# history
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^P' history-substring-search-up #up-history
bindkey '^N' history-substring-search-down #down-history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# load aliases
[ -f "$HOME/bin/shrc" ] && source "$HOME/bin/shrc"
# # source local file
[ ! -f "$HOME/.shrc.local" ] || source "$HOME/.shrc.local"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
