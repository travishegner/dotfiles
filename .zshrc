source ~/.antigen/antigen.zsh

antigen use oh-my-zsh
#antigen theme aussiegeek
#antigen theme gnzh
antigen theme ys
#antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen bundle colored-man
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
    # second (${(j. .)…}) joins the array into one string.
    ssh -t thegner@salt.ad.trilliumstaffing.com sudo salt "${(j. .)${(q)@}}"
}

tpass() {
	PASSWORD_STORE_DIR=/home/thegner/git_repos/passdb pass "$@"
}

#for working autocomplete:
compdef _tpass tpass
_tpass() {
	PASSWORD_STORE_DIR=/home/thegner/git_repos/passdb _pass
}

#clear the back buffer
clearbb() {
	echo -ne '\033c'
}
