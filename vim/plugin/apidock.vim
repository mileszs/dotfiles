" USE_RAKE_TO_DETECT_PLATFORM_OR_UNCOMMENT_THE_CORRECT_LINE
" LINUX :
let g:browser = 'xdg-open'
" WINDOWS :
" let g:browser = 'firefox -new-tab'
" OSX :
" let g:browser = 'open -a /Applications/Firefox.app'

" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/search/quick?query='.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>

" Open the Rails ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/search/quick?query='.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

" Open the Rspec ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRspecDoc(keyword)
  let url = 'http://apidock.com/rspec/search/quick?query='.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RS :call OpenRspecDoc(expand('<cword>'))<CR>
