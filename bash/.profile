export PATH=$PATH:$HOME/programs/shell/dmenu:$HOME/.global_node_modules/bin:

# Place user specific binaries here. Especially ones that you would like to
# keep in the repository
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.luarocks51/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export EDITOR='/usr/bin/nvim'

# When machine specific environment variables are needed place then in `~/.bash_env`
# Do not commit them to this repository
[[ -f ~/.bash_env ]] && . ~/.bash_env

. "$HOME/.cargo/env"
