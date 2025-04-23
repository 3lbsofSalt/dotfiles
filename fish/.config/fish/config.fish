alias ll="ls -lah"
alias vim="nvim"
alias gs="git status"
alias gc="git add .; git commit"
alias py='python'
alias gdv='nvim --listen ./godothost'

set -Ux MANPAGER "nvim +Man!"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/3lbsofSalt/.opam/opam-init/init.fish' && source '/home/3lbsofSalt/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
