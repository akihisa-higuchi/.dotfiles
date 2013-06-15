export LANG=ja_JP.UTF-8
export DISPLAY="localhost:0.0"

export PATH=/usr/local/bin:/usr/local/share:${PATH}
export PROJECTS="${HOME}/Documents/Projects"

export EDITOR=vim
export PAGER=less
bindkey -v

limit coredumpsize 0
unsetopt beep

# Prompt:#{{{
autoload -U colors && colors

setopt prompt_subst
unsetopt promptcr

PROMPT="%{${fg[red]}%}%n@%m %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[red]}%}%_> % %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}%/ %{${reset_color}%}"
#}}}

# Completion:"{{{
autoload -U compinit && compinit

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

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -U smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\][^[:space:]])*'
bindkey "^]" insert-last-word

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#}}}

# History:#{{{
HISTFILE=${HOME}/.zhistory
HISTSIZE=100000
SAVEHIST=100000

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
[[ ${OSTYPE} == freebsd* || ${OSTYPE} == darwin* ]] && alias ls="ls -G"
[[ ${OSTYPE} == linux* ]] && alias ls="ls --color=auto"
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'

# find
function findExec() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
function findInFilePattern() { find . -name "$2" | xargs grep -ni "$1"  ; }
alias fe=findExec
alias fifp=findInFilePattern

# Other
if [[ ${OSTYPE} == darwin* ]] ; then
    alias flushdns='dscacheutil -flushcache'
fi

#}}}

