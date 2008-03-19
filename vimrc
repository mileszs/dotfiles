" Vim Config File
"
" author: Miles Z. Sterrett <miles.sterrett@gmail.com>

" Tab and Indent Settings
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent

" Breifly show matching brace/parenthese/bracket
set showmatch

" Prevent vim from emulating vi bugs and limitations
set nocompatible

" each window will contain a status line with cursor position
set ruler

" search as you type
set incsearch

" keep 50 commands, etc in history
set history=50

" display an incomplete command in the lower right corner
set showcmd

" show line numbers
set number

syntax on
colorscheme vividchalk
