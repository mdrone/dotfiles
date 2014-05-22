# Created by newuser for 5.0.2
bindkey -v
# maps jk to escape, same as in my .vimrc
bindkey -M viins 'jk' vi-cmd-mode

autoload -U compinit promptinit
compinit
promptinit

umask 077
 
# This will set the default prompt to the walters theme
#prompt off
PROMPT="%? %l %T %~ "

#*xterm*|(u)rxvt|(u|dt|k|E)term)
bindkey '\e[1~' beginning-of-line
bindkey '\e[3~' delete-char
bindkey '\e[4~' end-of-line
bindkey '\177' backward-delete-char
bindkey '\e[2~' overwrite-mode

bindkey "\e[7~" beginning-of-line
bindkey "\e[H" beginning-of-line
#bindkey "\e[2~" transpose-words
bindkey "\e[8~" end-of-line
bindkey "\e[F" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

bindkey "^R" history-incremental-search-backward

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

if [ -f $HOME/.environment ]; then
    source $HOME/.environment
fi

if [ -f $HOME/.alias ]; then
    source $HOME/.alias
fi
