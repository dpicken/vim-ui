""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

let s:path_extension_cycle = {}

function s:RegisterPathExtensionCycle(...)
  if a:0 >= 2
    let extension_list_len = a:0
    for extension_record_idx in range(extension_list_len - 1) + [-1]
      let extension = a:000[extension_record_idx]
      let next_extension_record = a:000[extension_record_idx + 1]
      let s:path_extension_cycle[extension] = next_extension_record
    endfor
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialization

call s:RegisterPathExtensionCycle("h", "hpp", "inl.h", "il.h", "inlines.h", "cpp", "cc", "c")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function GetNextPathInCyle(path)
  let next_path = a:path

  let rm_extension_str = ":r:r"
  let first_extension = fnamemodify(a:path, ":e:e")
  let current_extension = first_extension
  if !has_key(s:path_extension_cycle, current_extension)
    let rm_extension_str = ":r"
    let first_extension = fnamemodify(a:path, ":e")
    let current_extension = first_extension
  endif

  while has_key(s:path_extension_cycle, current_extension)
    let next_extension = s:path_extension_cycle[current_extension]
    let next_path = fnamemodify(a:path, ":p" . rm_extension_str) . "." . next_extension
    if bufexists(next_path) || filereadable(next_path) || next_path == a:path
      break
    endif
    let current_extension = next_extension
  endwhile

  return next_path
endfunction
