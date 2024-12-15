abbr -a e nvim
abbr -a v vim
abbr -a m make
abbr -a g git
abbr -a gc 'git checkout'
abbr -a gs 'git status'
abbr -a gl 'git log --oneline'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'

set -x EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    # Allow local customizations
    if test -e "$HOME/.config/fish/config_local.fish"
	    builtin source "$HOME/.config/fish/config_local.fish"
    end

    if ! set -q TMUX
	    exec tmux
    end
end

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end
