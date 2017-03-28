""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

let s:path_separator = has("unix") ? '/' : '\'

function s:EnsureTrailingSlash(path)
  let trailing_slash_pattern = EscapeLiteralSearchPattern(s:path_separator) . '\+$'
  return substitute(a:path, trailing_slash_pattern, '', "") . s:path_separator
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function GetCWDPath()
  if has("unix")
    return s:EnsureTrailingSlash(fnamemodify(getcwd(), ":~"))
  else
    return s:EnsureTrailingSlash(getcwd())
  endif
endfunction

function GetHomePath()
  if has("unix")
    return s:EnsureTrailingSlash(fnamemodify($HOME, ":~"))
  else
    return s:EnsureTrailingSlash($HOME)
  endif
endfunction

function GetParentPath()
  if has("unix")
    return s:EnsureTrailingSlash(expand("%:p:~:h"))
  else
    return s:EnsureTrailingSlash(expand("%:p:h"))
  endif
endfunction

function GetPathSeparator()
  return s:path_separator
endfunction

function MakePath(...)
  let path = ""
  for path_component in a:000
    let path .= (path == "" ? "" : GetPathSeparator()) . path_component
  endfor
  return path
endfunction
