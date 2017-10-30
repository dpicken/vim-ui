""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function StripTrailingWhiteSpace()
  let restore_line = line(".")
  let restore_col = col(".")
  %substitute/\s\+$//e
  call cursor(restore_line, restore_col)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runtime

function s:CheckedStripTrailingWhiteSpace()
  if exists("g:ui_buf_strip_trailing_white_space_on_write") && g:ui_buf_strip_trailing_white_space_on_write ==? "yes"
    call StripTrailingWhiteSpace()
  endif
endfunction

function s:SetHardTabs()
  setlocal expandtab!
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
endfunction

function s:SetJavaBufferOptions()
  setlocal expandtab
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal tabstop=4
endfunction

if has("autocmd")
  augroup ui_buf
    autocmd!
    autocmd BufEnter Makefile,*.go,*.mk call s:SetHardTabs()
    autocmd BufEnter *.java call s:SetJavaBufferOptions()
    autocmd BufWritePre * call s:CheckedStripTrailingWhiteSpace()
  augroup END
endif
