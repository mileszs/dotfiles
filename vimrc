" Vim Config File
"
" author: Miles Z. Sterrett <miles.sterrett@gmail.com>

set nocompatible  " Prevent vim from emulating vi bugs and limitations
filetype off      " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-heroku'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'janx/vim-rubytest'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'rorymckinley/vim-rubyhash'
Plugin 'tomtom/quickfixsigns_vim'
Plugin 'benmills/vimux'
Plugin 'skalnik/vim-vroom'
Plugin 'ervandew/supertab'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'slim-template/vim-slim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomtom/tcomment_vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-scripts/AutoClose'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'mileszs/vim-react-snippets'
Plugin 'mxw/vim-jsx'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rizzatti/dash.vim'
Plugin 'scrooloose/syntastic'
Plugin 'elixir-lang/vim-elixir'
Plugin 'c-brenn/phoenix.vim'
Plugin 'tpope/vim-projectionist'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tclem/vim-arduino'
Plugin 'godlygeek/tabular'
Plugin 'dart-lang/dart-vim-plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" 256 colors
set t_Co=256

" Tab and Indent Settings
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set smartindent

set backspace=indent,eol,start

set title         " set terminal title
set history=50    " keep 50 commands, etc in history
set hidden        " More effective buffer handling
set showmatch     " Breifly show matching brace/parenthese/bracket
set autoread      " Auto-reload changed files
set ruler         " each window will contain a status line with cursor position
set showcmd       " display an incomplete command in the lower right corner
set number        " show line numbers
set scrolloff=3   " scroll before the border
set noswapfile

set hlsearch      " highlight search terms
set incsearch     " search as you type

set ignorecase
set smartcase     " case-smart searching

set colorcolumn=80

" File-type highlighting and configuration
syntax on
filetype plugin on
filetype indent on

" Preferred colorscheme
set background=dark
colorscheme solarized

" extended matching
runtime macros/matchit.vim

" more useful tab completion
set wildmenu
set wildmode=list:longest,list:full

" Shed light on hidden things
set list
set listchars=tab:»»,trail:•
set wrap
set linebreak
set showbreak=↳

" Highlight trailing whitespace characters and tabs not used for indention
highlight WhitespaceErrors ctermbg=Red guibg=Red
match WhitespaceErrors /\s\+$\|[^\t]\@<=\t\+/

" Remove trailing whitespace
noremap <silent> <Leader>rtw :%s/\s\+$//g<CR>``

" Map F9 to set foldmethod to syntax
map <F9> :set foldmethod=syntax<CR>

" Map ,cd to change to the directory of the file being edited
map ,cd :cd %:p:h<CR>

" Use the mouse in terminal Vim!
set mouse=a
set ttymouse=xterm2

" Swap ` and '.  ` is more useful in every situation
" that I can imagine!
noremap ' `
noremap ` '

" Take care of forgetting to use sudo with :w!!
cmap w!! %!sudo tee > /dev/null %

augroup mkd
  autocmd BufRead *.mkd,*.md,*.markdown  set ai formatoptions=tcroqn2 comments=n:>
augroup END

autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufNewFile,BufRead *.html.slim set filetype=slim

" JSX highlighting in regular JS files
let g:jsx_ext_required = 0

" quickfixsigns
let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']

" rails.vim projections
let g:rails_projections = {
      \ "features/*.feature": {"command": "feature"},
      \ "features/step_definitions/*.rb": {"command": "step"},
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "test": [
      \     "spec/services/%s_spec.rb"
      \   ]
      \ },
      \ "app/interactors/*.rb": {
      \   "command": "interactor",
      \   "test": [
      \     "spec/interactors/%s_spec.rb"
      \   ]
      \ },
      \ "app/forms/*.rb": {
      \   "command": "form",
      \   "test": [
      \     "spec/forms/%s_spec.rb"
      \   ]
      \ },
      \ "app/lib/*.rb": {
      \   "command": "lib",
      \   "test": [
      \     "spec/lib/%s_spec.rb"
      \   ]
      \ }
      \ }

" Split faster
nmap <silent> vv :vsp<CR>
nmap <silent> ss :sp<CR>

" AutoClose remapping
nmap <Leader>x <Plug>ToggleAutoCloseMappings

"Map esc to jj
inoremap jj <esc>

" Configure Syntastic for linter checks
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_rubocop_checker = 1
let g:syntastic_javascript_checkers = ['eslint']


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|doc)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }

let g:vroom_clear_screen=0
let g:vroom_use_vimux=1
let g:vroom_use_binstubs=0
let g:vroom_use_bundle_exec=1
let g:vroom_rspec_version='3.x'
let g:vroom_use_colors=0

" Arduino
" Default: /Applications/Arduino.app/Contents/Resources/Java
let g:vim_arduino_library_path = '/Users/mileszs/code/Arduino'
" Default: result of `$(ls /dev/tty.* | grep usb)`
let g:vim_arduino_serial_port = '/dev/tty.usbmodem1411'

" github
source /Users/mileszs/.vimgithubrc
