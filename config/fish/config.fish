# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via `fish_config` command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/
# See: http://fishshell.com/docs/current/tutorial.html#tut_startup

# $PATH is set via $fish_user_paths.
# See: https://fishshell.com/docs/current/tutorial.html#tut_universal

# Universal Defaults
set BROWSER open safari
set EDITOR vim
set DEVELOPER ~/Developer

# For Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# Sets brew cask symlink to /Applications instead of ~/Applications
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

# Golang workspace
set -x GOPATH $HOME/Developer/gocode

# For Fry ruby version manager
if test -f /usr/local/share/fry/fry.fish
  source /usr/local/share/fry/fry.fish
  # Set default version of ruby
  fry use 2.0.0-p648
end