source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh
#antigen theme aussiegeek
#antigen theme gnzh
antigen theme ys
#antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle vi-mode
antigen apply

# The following lines were added by compinstall
zstyle :compinstall filename '/home/thegner/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[Home]}"    ]]  && bindkey  -M vicmd "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[End]}"     ]]  && bindkey  -M vicmd "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
bindkey "^[Od" backward-word
bindkey -M vicmd "^[Od" backward-word
bindkey "^[Oc" forward-word
bindkey -M vicmd "^[Oc" forward-word

if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
  function zle-line-init () { echoti smkx }
  function zle-line-finish () { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

alias ls='ls --color=auto'
alias vim=nvim
alias yolo='packer -Syu --noedit --noconfirm'
alias time='/usr/bin/time -f "\nTime:\t\t%E\nRAM (kb):\t%M"'

#This is horribly, horribly a bad idea, I only do it for intranet appliances that use weak keys.
#Don't do this unless you want to be pwnd
alias google-chrome-unsafe='google-chrome-stable --cipher-suite-blacklist=0x0088,0x0087,0x0039,0x0038,0x0044,0x0045,0x0066,0x0032,0x0033,0x0016,0x0013'

#ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

saltssh() {
    port=$[${RANDOM}%1024+32700]
    ssh -t salt.trilliumstaffing.com sudo salt "${(j. .)${(q)@}} cmd.run \"ssh -i /etc/ssh/ssh-gw.ed25519 -p 22022 -o CheckHostIP=no -o HostKeyAlgorithms=ssh-ed25519 -R "$port":localhost:22 ssh-gw@salt.trilliumstaffing.com\" timeout=1"
    ssh -p $port -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null salt.trilliumstaffing.com
}

tssalt() {
    # First (${(q)@}) escapes all characters in the $@ array
    # that have special meaning,
    # second (${(j. .)…}) joins the array into one string
    ssh -t thegner@salt.ad.trilliumstaffing.com sudo salt "${(j. .)${(q)@}}"
}

tpass() {
  PASSWORD_STORE_DIR=/home/thegner/src/gitlab/docs/passdb pass "$@"
}

gclone() {
  dir=$(echo $1 | sed 's/^http\(s*\):\/\///g' | sed 's/^git@//g' | sed 's/\.git$//g' | sed 's/:/\//g' )
  git clone $1 "$HOME/src/$dir"
  cd "$HOME/src/$dir"
}

#for working autocomplete:
compdef _tpass tpass
_tpass() {
  PASSWORD_STORE_DIR=/home/thegner/src/gitlab/docs/passdb _pass
}

#clear the back buffer
clearbb() {
  echo -ne '\033c'
}

rwireshark() {
  local ipaddr=$(ip addr show enp7s0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')
  local host=$1
  shift
  local int=$1
  shift
  if [[ $@ ]]; then
    local args=" and $@"
  fi
    ssh $host "sudo tcpdump -i $int -U -s0 -w - \"not (port 22 and host ${ipaddr}) $args\"" | wireshark-gtk -k -i -
}

# added by travis gem
[ -f /home/thegner/.travis/travis.sh ] && source /home/thegner/.travis/travis.sh

unsetopt share_history
