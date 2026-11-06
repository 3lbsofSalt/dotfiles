# 3lbsofSalt's Dotfiles

Enjoy these dotfiles! Below are some things to watch out for:

## Note
Before use, please ensure that you have a `~/.config` directory and a `~/.local/[share,bin,state]` directory or things get weird

## How To Use
Navigate to the root directory and execute `stow [DIRECTORY NAME]` where `DIRECTORY NAME` is the name of
the directory for the tool or program you would like to configure. Ensure that
you have the software installed which makes use of the relevant configuration
files or stowing them will be pointless.

### Setting up a wayland compositor vs x11 window manager
A wayland compostor must define a `.wayinitrc` file to appear in `~/`. This will be ran from the `.profile`
as the wayland start script to start the display manager and anything else that needs to be started.

An X11 window manager needs to have `xinit` stowed, and the window manager must define a `.xinit.alt` file which will 
start the window manager and anything else that needs to be started.

#### Note
dwm-code is not a dotfile directory, but rather just my own dwn clone

### Machine Specific Environment Variables
The `~/.bash_env` file is sourced by `~/.profile` and is a file I came up with.
If you want to have some machine specific environment variables, but don't
want to save them to the repository, place them in that file, and __make sure
you don't commit it to the repository!__

### *_Theme Files

**This section no longer applies to the river window manager**
These files generally contain a wallpaper, a polybar config, and a `.fehbg` file.
The `.fehbg` file needs to be changed to reflect the username of the directory stow is stored in.


### CLI tools I Think I like, but I don't want to make default
- https://github.com/sharkdp/bat
- https://github.com/tldr-pages/tldr
- https://github.com/ogham/exa


#### Required Packages List/Specific Setup Instructions

##### River
- `wl-mirror`
- `xdg-desktop-portal-wlr`
- `xdg-desktop-portal-gtk`
- `slurp`
- `fuzzel`
- `alacritty`
- `waybar`

##### Neovim
###### For molten.nvim
molten.nvim breaks all of the time unless you do the following:
- Use ghostty as your terminal. It supports the kitty image protocol (you can use kitty, but I have ghostty set up in these dotfiles)
- Use uv as your python manager. This prevents python updates from breaking packages. Specifically, run the following commands:
    - `uv python install 3.12`
    - `uv venv --python 3.12 ~/.local/share/nvim/molten-venv`
    - `uv pip install --python ~/.local/share/nvim/molten-venv pynvim jupyter_client nbformat pillow jupytext ipython jupyter_client cairosvg pnglatex plotly kaleido pyperclip nbformat PIL`
    - In init.lua there is the command `vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/molten-venv/bin/python")` which will ensure all vim utilized python packages will come from there
- Ensure that the `imagemagick` package is installed on your machine. We are no longer using the luarock, thank goodness.

##### Alacritty
Get the Iosevka font installed (`pacman -S ttc-iosevka`). 
If you want themes, follow the instructions here: [](https://github.com/alacritty/alacritty-theme)
