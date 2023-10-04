# 3lbsofSalt's Dotfiles

Enjoy these dotfiles! Below are some things to watch out for:

## How To Use
Navigate to the root directory and execute `stow [DIRECTORY NAME]` where `DIRECTORY NAME` is the name of
the directory for the tool or program you would like to configure. Ensure that
you have the software installed which makes use of the relevant configuration
files or stowing them will be pointless.

### Machine Specific Environment Variables
The `~/.bash_env` file is sourced by `~/.profile` and is a file I came up with.
If you want to have some machine specific environment variables, but don't
want to save them to the repository, place them in that file, and __make sure
you don't commit it to the repository!__

### *_Theme Files

These files generally contain a wallpaper, a polybar config, and a `.fehbg` file.
The `.fehbg` file needs to be changed to reflect the username of the directory stow is stored in.

### CLI tools I Think I like, but I don't want to make default
- https://github.com/sharkdp/bat
- https://github.com/tldr-pages/tldr
- https://github.com/ogham/exa
