#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

umask 077

#Standard
#PS1='[\u@\h \W]\$ '


PS1='\[\033[0;37m\][$?]-\[\033[0;32m\][\!]-\[\e[31m\][\t]-\[\e[32m\][\h]-\[\e[33m\][\w]\n\[\033[0;35m\] \$\[\e[0m\] '


#news feed
if [ "$PS1" ]; then
# The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
    echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | awk ' NR == 1 {while ($0 !~ /<\/item>/) {print;getline} sub(/<\/item>.*/,"</item>") ;print}' | sed -e ':a;N;$!ba;s/\n/ /g') | \
        sed -e 's/&amp;/\&/g
        s/&lt;\|&#60;/</g
        s/&gt;\|&#62;/>/g
        s/<\/a>/£/g
        s/href\=\"/§/g
        s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
        s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
        s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
        s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
        s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
        s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
        s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
        s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
        s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
        s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
        s/<!\[CDATA\[\|\]\]>//g
        s/\|>\s*<//g
        s/ *<[^>]\+> */ /g
        s/[<>£§]//g')\n";
fi
echo -e "\033[0;35m$(/usr/bin/fortune)\n"

if [ -f $HOME/.alias ]; then
    source $HOME/.alias
fi

if [ -f $HOME/.helpers ]; then
    source $HOME/.helpers
fi

if [ -f $HOME/.environment ]; then
    source $HOME/.environment
fi

if [ -f $HOME/perl5/perlbrew/etc/bashrc ]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

#set -o vi
#bind -m vi-command ".":insert-last-argument
#bind -m vi-insert "\C-l.":clear-screen
#bind -m vi-insert "\C-a.":beginning-of-line
#bind -m vi-insert "\C-e.":end-of-line
#bind -m vi-insert "\C-w.":backward-kill-word

#Debug-mode
#set -xv
