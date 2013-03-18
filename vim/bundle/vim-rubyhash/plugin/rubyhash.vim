if !exists('g:rubyhash_map_keys')
  let g:rubyhash_map_keys=1
endif

if g:rubyhash_map_keys==1
  nnoremap <silent> <Leader>rs :call ToSymbolKeysLinewise()<CR>
  nnoremap <silent> <Leader>rt :call ToStringKeysLinewise()<CR>
  nnoremap <silent> <Leader>rr :call To19KeysLinewise()<CR>
endif

function! ToSymbolKeysLinewise()
  :ruby Convert::to_symbols
endfunction

function! To19KeysLinewise()
  :ruby Convert::to_19
endfunction

function! ToStringKeysLinewise()
  :ruby Convert::to_strings
endfunction

ruby << EOF
module Convert
  def self.to_symbols
    search_and_replace([ 
      { :search => /['"](\w+)['"](?=\s*=>)/, :replace => ':\1' },
      { :search => /((?:\{|,|^)\s*)(\w+):/, :replace => '\1:\2 =>'}
    ])
  end

  def self.to_strings
    search_and_replace([
      { :search => /:(\w+)(?=\s*=>)/, :replace => '"\1"'},
      { :search => /((?:\{|,|^)\s*)(\w+):/, :replace => '\1"\2" =>'},
    ])
  end

  def self.to_19
    search_and_replace([
      { :search => /:(\w+)\s*=>/, :replace => '\1:'},
      { :search => /['"](\w+)['"]\s*=>/, :replace => '\1:'},
    ])
  end

  private

  def self.search_and_replace(patterns=[])
    contents = VIM::Buffer.current.line
    patterns.each { |params| contents.gsub!(params[:search], params[:replace]) }
    VIM::Buffer.current.line = contents
  end
end
EOF
