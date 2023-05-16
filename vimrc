" Vim Config File
"
" author: Miles Z. Sterrett <miles.sterrett@gmail.com>

set nocompatible  " Prevent vim from emulating vi bugs and limitations
filetype off      " required for Vundle

call plug#begin('~/.vim/plugged')

Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" optional for icon support
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'sheerun/vim-polyglot'

Plug 'janko-m/vim-test'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-heroku'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-projectionist'
Plug 'tomtom/quickfixsigns_vim'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'janx/vim-rubytest'
Plug 'mattn/gist-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/AutoClose'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'c-brenn/phoenix.vim'
Plug 'dense-analysis/ale'

" themes
Plug 'ajmwagar/vim-deus'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/forest-night'
Plug 'sainnhe/sonokai'

call plug#end()

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

" Important!! for color schemes
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" MUST OCCUR BEFORE colorscheme call!
" configuration for forest-night
let g:forest_night_enable_italic = 1
let g:forest_night_disable_italic_comment = 1

" MUST OCCUR BEFORE colorscheme call!
"configuration for deus scheme
let g:deus_termcolors=256

" MUST OCCUR BEFORE colorscheme call!
"configuration for sonokai scheme
let g:sonokai_style = 'maia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
let g:seoul256_background = 234
colo seoul256

" Set colorscheme and background
set background=dark
colorscheme seoul256

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
if !has('nvim')
  set ttymouse=xterm2
endif

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

" ALE linters
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_linters_explicit = 1

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

" CtrlP -> FZF
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>

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

" vim-test
let test#strategy = "vimux"
noremap tsl :TestNearest<CR>
noremap ts; :TestFile<CR>
noremap ts' :TestSuite<CR>
noremap tss :TestLast<CR>

" Ignore deprecation warnings so I can see the results
let test#ruby#rspec#options = '--deprecation-out /dev/null'

" github
" source /Users/mileszs/.vimgithubrc

let g:python3_host_prog = '/usr/local/bin/python3' " -- Set python 3 provider
