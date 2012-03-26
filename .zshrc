autoload -U compinit
compinit

export LANG=ja_JP.UTF-8
limit coredumpsize 102400
setopt nobeep

## Keybind vim|emacs
bindkey -v
#bindkey -e

## Completion
setopt auto_param_keys
setopt correct
setopt list_packed
setopt list_types
setopt numeric_glob_sort

setopt auto_cd
setopt auto_pushd
setopt auto_resume
setopt equals
setopt extended_glob
setopt long_list_jobs
setopt magic_equal_subst
setopt print_eight_bit
setopt prompt_subst
unsetopt promptcr

## History
HISTFILE=${HOME}/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_verify
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    [[ ${#line} -ge 5
        && ${cmd} != (l[salf])
        && ${cmd} != (man)
    ]]
}

## Alias
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias screen='screen -U -d -R'
alias du="du -h"
alias df="df -h"
alias j="jobs -l"
alias where="command -v"
# ls
alias la='ls -a'
alias ll='ls -l'
alias lf='ls -F'
# vim
alias v='vim'
alias vr='vim -R'
# global alias
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
# cd
alias xtrmjp='cd /Users/akihisa/Documents/Work/Solutions/Web/xtrm_jp/'

## Prompt
autoload colors
colors

PROMPT="%{${fg[red]}%}[%n@%m] %{${reset_color}%}"
PROMPT2="%{${fg[red]}%}[%n@%m] %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}%/ %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#export LESS='--tabs=4 --no-limit --LONG-PROMPT --ignore-case'

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\][^[:space:]])*'
bindkey "^]" insert-last-word

export PATH=/usr/local/bin:/usr/local/share:$PATH
export DISPLAY=:0.0

