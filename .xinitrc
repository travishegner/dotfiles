#!/bin/bash

source ~/.zshrc
xrdb ~/.Xresources
export EDITOR=vim
export GOPATH=~/go
export PATH=$HOME/tools/bin:$GOPATH/bin:$PATH
export LANG=en_US.UTF-8
export PKG_CONFIG_PATH=:$HOME/tools/pkgconfig$PKG_CONFIG_PATH

#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

awesome &
pid=$!
sleep 1

#xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D1 -O.02 -I.02 &
xcompmgr -CcfF -I0.5 -O0.5 -D1 -t-5 -l-5 -r4.2 -o.82 &
pulseaudio --start &
volumeicon &
xchat &
conky &

sudo mount --bind ~/src ~/go/src

wait $pid
