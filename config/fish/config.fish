#  ______     ______     __   __     ______   __     ______     ______   __     ______     __  __
# /\  ___\   /\  __ \   /\ "-.\ \   /\  ___\ /\ \   /\  ___\   /\  ___\ /\ \   /\  ___\   /\ \_\ \
# \ \ \____  \ \ \/\ \  \ \ \-.  \  \ \  __\ \ \ \  \ \ \__ \  \ \  __\ \ \ \  \ \___  \  \ \  __ \
#  \ \_____\  \ \_____\  \ \_\\"\_\  \ \_\    \ \_\  \ \_____\  \ \_\    \ \_\  \/\_____\  \ \_\ \_\
#   \/_____/   \/_____/   \/_/ \/_/   \/_/     \/_/   \/_____/   \/_/     \/_/   \/_____/   \/_/\/_/

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/config/fish/config.fish
# Twitter:    @jsatk

# }}}
# General {{{

# Note: All git aliases and configs stored in ~/.gitconfig.
# Fish prompt can be modified via `fish_config` command or in ~/.config/fish/functions/fish_prompt.fish
# Fish functions are all stored in ~/.config/fish/functions/
# See: http://fishshell.com/docs/current/tutorial.html#tut_startup

# $PATH is set via $fish_user_paths with `set -U` so it persists.
# See: https://fishshell.com/docs/current/tutorial.html#tut_universal

# Universal Defaults
set BROWSER open safari
set EDITOR vim
set DEVELOPER ~/Developer
# Required for n
set --export N_PREFIX ~/n
set PATH $N_PREFIX/bin ~/.rbenv/shims /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin /usr/local/MacGPG2/bin ~/Library/scripts

# For Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# Sets brew cask symlink to /Applications instead of ~/Applications
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications'

export EDITOR

# For prompt
export powerline_symbols="$HOME/Dropbox (Personal)/dotfiles/fontpatcher/fonts/powerline-symbols.sfd"

# For rbenv ruby version manager
# This modifies your path and adds the `.rbenv` folder to it.
if test -f /usr/local/bin/rbenv
    status --is-interactive; and source (rbenv init -|psub)
end

# For Github Dashboard in Vim
source ~/.vim-ghd-token
# }}}
# For Khan Academy  {{{

# For Google Cloud
if test -d $HOME/google-cloud-sdk
  # bass allows fish shell to invoke bash scripts.
  # It's a function at ~/.config/fish/functions/bass.fish

  # The next line updates PATH for the Google Cloud SDK.
  bass source "$HOME/google-cloud-sdk/path.bash.inc"

  # The next line enables shell command completion for gcloud.
  bass source "$HOME/google-cloud-sdk/completion.bash.inc"
end

if test -d $HOME/khan/webapp
  # Add frankenserver bins to PATH
  set PATH $HOME/khan/webapp/third_party/frankenserver $PATH
end

if test -d $HOME/khan/devtools
  # Add devtools bins to PATH
  # TODO(mroth): rewrite these paths at install time based on user preference
  set --export KA_DEVROOT $HOME/khan/devtools
  set PATH $KA_DEVROOT/arcanist/khan-bin $KA_DEVROOT/git-workflow/bin $KA_DEVROOT/ka-clone/bin $KA_DEVROOT/khan-linter/bin $PATH
end

# For virtualfish, a Fish Shell wrapper for virtualenv
eval (python -m virtualfish)
vf activate khan27

# }}}
