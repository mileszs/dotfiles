" Vim Config File
"
" author: Miles Z. Sterrett <miles.sterrett@gmail.com>

call pathogen#infect()
call pathogen#helptags()

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
set nocompatible  " Prevent vim from emulating vi bugs and limitations
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

" File-type highlighting and configuration
syntax on
filetype on
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


" tslime
vmap <Leader>rs <Plug>SendSelectionToTmux
nmap <Leader>rt <Plug>NormalModeSendToTmux
nmap <Leader>rr <Plug>SetTmuxVars

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
      \ }
      \ }

let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!zeus rspec {spec}"
" let g:rspec_command = "Dispatch rspec {spec}"

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>"

" Split faster
nmap <silent> vv :vsp<CR>
nmap <silent> ss :sp<CR>

" github
source /Users/mileszs/.vimgithubrc
