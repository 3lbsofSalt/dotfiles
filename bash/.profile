export PATH=$PATH:$HOME/programs/shell/dmenu:$HOME/.global_node_modules/bin

# Created by `pipx` on 2021-07-21 06:01:40
export PATH="$PATH:/home/madram/.local/bin"

# To use yarn global packages
export PATH="$PATH:$HOME/.yarn/bin"

# For development of Badger's Workorder System
export COMPOSE_PROFILES="development"

export EDITOR='/usr/bin/vim'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
