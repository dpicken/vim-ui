""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function EscapeLiteralSearchPattern(literal_text)
  let pattern = escape(a:literal_text, '\\/.*$^~[]')
  let pattern = substitute(pattern, '\n', '\\n', "g")
  return pattern
endfunction

function FindFileAndSwitchBuf(name)
  let target = resolve(findfile(a:name))
  if target == ""
    echo a:name . ": not found"
    return
  endif
  call SwitchBuf(target)
endfunction

function ToggleLocalOption(option_name)
  execute "setlocal " . a:option_name . "! " . a:option_name . "?"
endfunction
