""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function MoveCursorThroughCamelCase(flags)
  call search('\m\([A-Z]\+[0-9a-z]*\)\|\([a-z]\+[0-9a-z]*\)\|\([^0-9A-Za-z_ ]\+\)\|\(^$\)', a:flags)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runtime

function s:MoveCursorToLastKnownPosition()
  if line("'\"") > 0 && line("'\"") <= line ("$")
    normal g`"
  endif
endfunction

if has("autocmd")
  augroup ui_cursor
    autocmd!
    autocmd BufReadPost * call s:MoveCursorToLastKnownPosition()
  augroup END
endif
