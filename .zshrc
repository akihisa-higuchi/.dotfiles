autoload -U compinit
compinit

export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:/usr/local/share:$PATH
export DISPLAY=:0.0

bindkey -v

limit coredumpsize 0
setopt nobeep

# Completion:"{{{
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
#}}}

# History:#{{{
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=${HOME}/.zhistory

setopt hist_no_store
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_verify
setopt extended_history
setopt inc_append_history
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # ignore those command
    [[ ${#line} -ge 5
        && ${cmd} != (l[salf])
        && ${cmd} != (man)
    ]]
}
#}}}

# Alias:#{{{
setopt complete_aliases

alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g GI='|grep -i'
alias -g L='|less'

alias -s {conf,sh,c,h,cpp,html,php}=vim

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias du="du -h"
alias df="df -h"
alias where="command -v"

alias v='vim'
alias vr='vim -R'
alias screen='screen -U -d -R'

# ls
case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'

# cd
alias xtrmjp='cd /Users/akihisa/Documents/Work/Solutions/Web/xtrm_jp/'

#}}}

# Prompt:#{{{
autoload -U colors
colors

PROMPT="%{${fg[red]}%}[%n@%m] %{${reset_color}%}"
PROMPT2="%{${fg[red]}%}[%n@%m] %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}%/ %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -U smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\][^[:space:]])*'
bindkey "^]" insert-last-word
#}}}

