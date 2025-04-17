#
# ~/.profile
#

# Global settings
export EDITOR=vim
export VISUAL=vim
umask 0077

# Useful shortcuts
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'

# Add local paths
export PATH="$HOME/.local/bin:$PATH"
export CPATH="$HOME/.local/include:$CPATH"
export LIBRARY_PATH="$HOME/.local/lib:$LIBARY_PATH"
export LIBRARY_PATH="$HOME/.local/lib64:$LIBARY_PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBARY_PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib64:$LD_LIBARY_PATH"

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"

# Default compilation flags
export MAKEFLAGS="-j8"

# Bluespec stuff
export BSPATH=/opt/bluespec
export PATH="$BSPATH/bin:$PATH"
export BLUESPECDIR=$BSPATH/lib/
export EMAIL=tcpc@mit.edu
