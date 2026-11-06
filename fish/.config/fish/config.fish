alias ll="ls -lah"
alias vim="nvim"
alias gs="git status"
alias gc="git add .; git commit"
alias py='python'
alias gdv='nvim --listen ./godothost'

set -Ux MANPAGER "nvim +Man!"

fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.npm-global/bin


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/3lbsofSalt/.opam/opam-init/init.fish' && source '/home/3lbsofSalt/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/max/miniconda3/bin/conda
    eval /home/max/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/max/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/max/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/max/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

