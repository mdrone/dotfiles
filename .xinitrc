#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#source .bashrc

# set german keyboard layout (disable caps lock)
# setxkbmap -layout de & #-option ctrl:nocaps &&
# set ESC to CAPS
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
# load custom config for X
xmodmap .xmodmaprc &

start-pulseaudio-x11

xbindkeys &
xset -b
xset s off
setterm -blank 0 -powerdown 0

#TransparencyFancy
#xcompmgr -c -f -D 5 &


#SLiM Menu /etc/slim.conf
#exec $1

DEFAULT_WM=awesome

case $1 in
dwm)
    exec dwm
    ;;
twm)
    exec twm
    ;;
icewm-session)
    exec icewm-session
    ;;
blackbox)
    exec blackbox
    ;;
i3)
    exec i3
    ;;
wmaker)
    exec wmaker
    ;;
ratpoison)
    exec ratpoison
    ;;
xmonad)
    exec xmonad
    ;;
xfce4)
    exec startxfce4
    ;;
*)
    exec $DEFAULT_WM
esac

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
