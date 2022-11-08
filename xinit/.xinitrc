#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
echo "Start"

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

echo "Moving"

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

echo "Moving2"

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

echo "Moving3"

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
echo "Starting xorg"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

echo "Starting i3"

sh ~/.fehbg &
spotifyd --no-daemon &
setxkbmap us -variant colemak
exec i3
