alias o="xdg-open"

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

export BAT_THEME="ansi"
export PAGER="less"
export EDITOR="nvim"

function fish_greeting

end

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 33467c
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

starship init fish | source
