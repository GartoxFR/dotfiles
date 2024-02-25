alias o="xdg-open"

alias ls=exa

alias vim=nvim
alias vi=nvim

alias gla="git log --all --graph --decorate --oneline"
alias g 'git'
alias ga 'git add'
alias ga. 'git add .'
alias gap 'git add --patch'
alias gapn 'git add --intent-to-add .; and git add --patch'
alias gb 'git branch'
alias gc 'git commit'
alias gca 'git commit --amend'
alias gp 'git push'
alias gs 'git status'
alias gd 'git diff'
alias gl 'git log'
alias gf 'git fetch'
alias gfp 'git fetch; and git pull'
alias gt 'git tag'

function mkcd
  mkdir $argv
  and cd $argv
end

export BAT_THEME="ansi"
export PAGER="less"
export EDITOR="nvim"

function fish_greeting

end
fish_vi_key_bindings

fish_add_path /home/ewan/work/bin
fish_add_path /home/ewan/dotfiles/rofi/bin

starship init fish | source

export LIBVIRT_DEFAULT_URI="qemu:///system"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/ewan/.ghcup/bin $PATH # ghcup-env

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/ewan/.ghcup/bin $PATH # ghcup-env
set -gx PATH $HOME/.cargo/bin $PATH

function dual
    xrandr --output HDMI-1-0 --auto --primary --right-of eDP-1 --auto
    nitrogen --restore 2> /dev/null
end

function single
    xrandr --output eDP-1 --primary --auto
    xrandr --output HDMI-1-0 --off
    nitrogen --restore 2> /dev/null
end
