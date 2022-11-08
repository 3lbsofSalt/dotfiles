command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

set nocompatible
filetype off

" Set up the tabs to be 4 spaces
set tabstop=2 shiftwidth=2
set expandtab

" nothing like some not so smart indents
set autoindent

"the most important line of my vimrc
set number

" Autoread file changes
set autoread

" Syntax
syntax enable

" Colemak keybindings
noremap n j
noremap e k
noremap i l

noremap I L
noremap N J
noremap E K

noremap l i
noremap k e
noremap j n

noremap L I
noremap K E
noremap J N

noremap <C-W>n <C-W>j
noremap <C-W>N <C-W>J
noremap <C-W>e <C-W>k
noremap <C-W>E <C-W>K
noremap <C-W>i <C-W>l
noremap <C-W>I <C-W>L

"""""
"Vundle Stuff

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

    Plugin 'tpope/vim-surround'
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'captbaritone/better-indent-support-for-php-with-html'
    Plugin 'leafOfTree/vim-vue-plugin'
    Plugin 'itchyny/lightline.vim'
    Plugin 'dense-analysis/ale'
    Plugin 'ajmwagar/vim-deus'
    Plugin 'junegunn/fzf.vim'
    Plugin 'sonph/onehalf'
    Plugin 'MaxMEllon/vim-jsx-pretty'

call vundle#end()

" Colorscheme Stuff

colors deus

" Makes lightline work
set laststatus=2

" Get rid of the --Insert-- bar because we have lightline instead
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'deus',
    \ }

" FZF Settings

" Place these two lines in your bashrc and fzf will work beautifully
" export FZF_DEFAULT_OPTS='--border'
" export FZF_DEFAULT_COMMAND="find . -type d \( -name node_modules -o -name .git -o -name .nuxt \) -prune -false -o -name '*'"
noremap <C-f> <Cmd>FZF<CR>
noremap <C-g> <Cmd>Rg<CR>


" Allow for project-specific vimrc's
set exrc
set secure
