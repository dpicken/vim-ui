""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

function s:WindowInUse()
  return expand("%:p") != "" || &modified != 0
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function EscapeLiteralPath(literal_path)
  let pattern = escape(a:literal_path, ' %')
  let pattern = substitute(pattern, '\n', '\\n', "g")
  return pattern
endfunction

function SwitchBuf(path)
  if &switchbuf =~ '\(usetab\)\|\(useopen\)'
    let buf_nr = bufnr(fnamemodify(a:path, ":p") . '$')
    if buf_nr != -1
      let tab_nr_list = &switchbuf =~ 'usetab' ? range(1, tabpagenr("$")) : [tabpagenr()]
      for tab_nr in tab_nr_list
        for tbuf_nr in tabpagebuflist(tab_nr)
          if tbuf_nr == buf_nr
            execute "tabnext " . tab_nr
            execute bufwinnr(buf_nr) . "wincmd w"
            return
          endif
        endfor
      endfor
    endif
  endif

  let path = EscapeLiteralPath(a:path)

  if s:WindowInUse() != 0
    if &switchbuf =~ 'newtab' || v:version < 702
      execute "tabedit " . path
      return
    elseif &switchbuf =~ 'split'
      execute "split " . path
      return
    endif
  endif

  execute "edit " . path
endfunction

command! -nargs=1 -complete=file SwitchBuf call SwitchBuf(<f-args>)
