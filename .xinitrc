#!/bin/bash
export PATH=$HOME/tools/bin:$GOPATH/bin:$HOME/.gem/ruby/2.3.0/bin:$PATH
export TERMINAL=xfce4-terminal

cat /home/thegner/src/github.com/travishegner/dotfiles/.config/i3/config.base /home/thegner/src/github.com/travishegner/dotfiles/.config/i3/config.$(hostname) > /home/thegner/.config/i3/config

session=$1

source ~/tools/bin/detect_outputs
# .zshrc is sourced automatically, and sourcing here now causes syntax errors with other shells
#source ~/.zshrc
#xrdb ~/.Xresources
export EDITOR=nvim
export GOPATH=~/go
export LANG=en_US.UTF-8
export PKG_CONFIG_PATH=:$HOME/tools/pkgconfig$PKG_CONFIG_PATH
export JAVA_HOME=/usr/lib/jvm/default/
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

#sudo mount --bind ~/src ~/go/src

xscreensaver -no-splash &
twmnd &
#xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D1 -O.02 -I.02 &
xcompmgr -CcfF -I0.5 -O0.5 -D1 -t-5 -l-5 -r4.2 -o.82 &
volumeicon &
nm-applet &
#xchat &
#mattermost-desktop &
numlockx on &
#autocutsel -fork
#autocutsel -selection PRIMARY -fork
#redshift -l 42.324696:-85.522443 &
#zinc -start

case $session in
"i3")
	feh --bg-scale /home/thegner/tools/arch_linux_gnu-32977.png
	;;
esac
