""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

function s:GetProjectPathHelper(buffer_path, project_container_path)
  let project_path_pattern = '\(' . escape(a:project_container_path . GetPathSeparator() . '[^' . GetPathSeparator() . ']*', '\\') . '\)*\(.*\)'
  let project_path = substitute(a:buffer_path, project_path_pattern, '\1', "")
  return project_path
endfunction

let g:ui_project_container_paths = []

function s:GetProjectPathImpl(buffer_path)
  for project_container_path in g:ui_project_container_paths
    let project_path = s:GetProjectPathHelper(a:buffer_path, project_container_path)
    if project_path != ""
      return project_path
    endif
  endfor
  return ""
endfunction

let g:ui_project_relative_file_search_paths = []
let g:ui_project_absolute_file_search_paths = []

function s:SetProject(buffer_path)
  let project_path = s:GetProjectPathImpl(a:buffer_path)
  if project_path == ""
    return
  endif

  execute "setlocal tags<"
  execute "setlocal tags+=" . MakePath(project_path, "tags")

  execute "setlocal path<"
  execute "setlocal path+=" . project_path

  for path in g:ui_project_relative_file_search_paths
    execute "setlocal path+=" . MakePath(project_path, path)
  endfor

  for path in g:ui_project_absolute_file_search_paths
    execute "setlocal path+=" . path
  endfor
endfunction

let g:ui_project_dirnames_excluded_from_guard = []
let g:ui_project_dirnames_excluded_from_namespace = []

function s:InsertCHeaderBoilerPlateImpl()
  let buffer_path = expand("%:p")

  if fnamemodify(buffer_path, ":t") == ""
    return
  endif

  let project_path = s:GetProjectPathImpl(buffer_path)

  let project_path_pattern = '^' . project_path . GetPathSeparator()
  let buffer_path_leaf = substitute(buffer_path, project_path_pattern, "", "")
  let buffer_path_leaf_components = split(buffer_path_leaf, GetPathSeparator())
  if has("windows") && buffer_path_leaf_components[0] =~ '[A-Z]:'
    call remove(buffer_path_leaf_components, 0)
  endif

  let invalid_token_chars_pattern = '[. :-]'

  let guard = ""
  for guard_element in buffer_path_leaf_components
    if index(g:ui_project_dirnames_excluded_from_guard, guard_element) == -1
      let guard_element = substitute(guard_element, invalid_token_chars_pattern, "_", "g")
      let guard .= (strlen(guard) == 0 ? "" : "_") . guard_element
    endif
  endfor

  let namespace_elements = buffer_path_leaf_components
  call remove(namespace_elements, len(namespace_elements)-1)

  let namespace_open = ""
  let namespace_close_head = ""
  let namespace_close_tail = ""
  for namespace_element in namespace_elements
    if index(g:ui_project_dirnames_excluded_from_namespace, namespace_element) == -1
      let namespace_element = substitute(namespace_element, invalid_token_chars_pattern, "_", "g")
      let namespace_open .= (strlen(namespace_open) == 0 ? "" : " ") . "namespace " . namespace_element . " {"
      let namespace_close_head .= "} "
      let namespace_close_tail .=  (strlen(namespace_close_tail) == 0 ? "" : "::") . namespace_element
    endif
  endfor

  if namespace_open != ""
    call append(0, "")
    call append(0, namespace_open)
  endif

  let buffer_path_extension = fnamemodify(buffer_path, ":e:e")
  let add_c_include_guard = (buffer_path_extension == "h" || buffer_path_extension == "fwd.h" || buffer_path_extension == "inl.h")

  if add_c_include_guard
    call append(0, "")
    call append(0, "#define " . guard)
    call append(0, "#ifndef " . guard)
  endif

  if namespace_close_head != ""
    call append(line("$"), "")
    call append(line("$"), namespace_close_head . "// namespace " . namespace_close_tail)
  endif

  if add_c_include_guard
    call append(line("$"), "")
    call append(line("$"), "#endif // ifndef " . guard)
  endif
endfunction

function s:GetCurrrentPathOrDirectory()
  let path = expand("%:p")
  if path == ""
    let path = getcwd()
  endif
  return path
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" API

function GetProjectPathUsingCurrentPathOrDirectory()
  return s:GetProjectPathImpl(s:GetCurrrentPathOrDirectory())
endfunction

function InsertCHeaderBoilerPlate()
  call s:InsertCHeaderBoilerPlateImpl()
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runtime

function s:SetProjectUsingCurrentFileOrDirectory()
  call s:SetProject(s:GetCurrrentPathOrDirectory())
endfunction

if has("autocmd")
  augroup ui_project
    autocmd!
    autocmd BufNewFile  * call s:SetProjectUsingCurrentFileOrDirectory()
    autocmd BufFilePost * call s:SetProjectUsingCurrentFileOrDirectory()
    autocmd BufEnter    * call s:SetProjectUsingCurrentFileOrDirectory()
    autocmd VimEnter    * call s:SetProjectUsingCurrentFileOrDirectory()
  augroup END
endif
