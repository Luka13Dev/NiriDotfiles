#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias up='sudo pacman -Syu --noconfirm'
alias in='sudo pacman -S --needed --noconfirm'
alias rv='sudo pacman -Rcns --noconfirm'
alias sr='pacman -Ss'
alias si='pacman -Qs'
alias fup='flatpak update -y'
alias fin='flatpak install --user -y'
alias frv='flatpak uninstall --user -y --delete-data'
alias ff='fastfetch'
alias cl='clear'

PS1='[\u@\h \W]\$ '

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

[[ -f ~/.cache/terminal-sequences ]] && (cat ~/.cache/terminal-sequences &)

eval "$(starship init bash)"
