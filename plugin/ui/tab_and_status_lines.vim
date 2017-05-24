""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

" Returns the current buffer's character encoding.
function GetBufferEncoding()
  return &fileencoding != "" ? &fileencoding : &encoding
endfunction

" Returns a char indicating whether the current/specified buffer has been
" modified.
function GetBufferModifiedChar(...)
  let buf_expr = a:0 == 0 ? "%" : a:1

  if getbufvar(buf_expr, "&modified") != 0
    return "*"
  elseif getbufvar(buf_expr, "&modifiable") == 0
    return "-"
  else
    return ""
  endif
endfunction

" Returns a string containing the file name and modification indication of the
" specified tab's current buffer.
function s:GetTabLabel(tab_nr)
  let winnr_idx = tabpagewinnr(a:tab_nr) - 1
  let buf_nr = tabpagebuflist(a:tab_nr)[winnr_idx]
  let path = bufname(buf_nr)
  let path = fnamemodify(path, ":t")
  let tab_label = substitute(path, '^$', '[No Name]', "")
  let tab_label .= GetBufferModifiedChar(buf_nr)
  return tab_label
endfunction

" Formats the string returned by GetTabLabel():
"   - truncates string if necessary.
"   - adds a separator character to either end of the string (space, or '<'/'>'
"     if the string is truncated).
function s:GetFormattedTabLabel(tab_nr, tab_label_max_length, truncate_tail)
  let tab_label = s:GetTabLabel(a:tab_nr)
  let tab_label_length = strlen(tab_label)

  let tab_label_max_length = a:tab_label_max_length > 2 ? a:tab_label_max_length - 2 : 0

  if a:truncate_tail == 0
    let tab_label_start = tab_label_length < tab_label_max_length ? 0 : tab_label_length - tab_label_max_length
    let tab_label = strpart(tab_label, tab_label_start)
    let left_separator = tab_label_start != 0 ? "<" : " "
    return (a:tab_label_max_length > 0 ? left_separator : "") . tab_label . (a:tab_label_max_length > 1 ? " " : "")
  else
    let tab_label_end = tab_label_length < tab_label_max_length ? tab_label_length : tab_label_max_length
    let tab_label = strpart(tab_label, 0, tab_label_end)
    let right_separator = tab_label_end != tab_label_length ? ">" : " "
    return (a:tab_label_max_length > 1 ? " " : "") . tab_label . (a:tab_label_max_length > 0 ? right_separator : "")
  endif
endfunction

" Generates a string that can be used to set the 'tabline' option.
" Ensures the current tab is always displayed, by scrolling the previously
" displayed tabs when the tab line is wider than the current number of columns.
function GetTabLine()
  let tab_nr_begin = 1
  let tab_nr_active = tabpagenr()
  let tab_nr_end = tabpagenr("$")

  let s:previous_untruncated_tab_nr_begin = exists("s:previous_untruncated_tab_nr_begin")
\   ? (s:previous_untruncated_tab_nr_begin > tab_nr_active ? tab_nr_active : s:previous_untruncated_tab_nr_begin)
\   : tab_nr_begin
  let s:previous_untruncated_tab_nr_end = exists("s:previous_untruncated_tab_nr_end") && s:previous_untruncated_tab_nr_end < tab_nr_end
\   ? (s:previous_untruncated_tab_nr_end < tab_nr_active ? tab_nr_active : s:previous_untruncated_tab_nr_end)
\   : tab_nr_end

  let s:previous_tab_nr_begin = exists("s:previous_tab_nr_begin")
\   ? (s:previous_tab_nr_begin > s:previous_untruncated_tab_nr_begin ? s:previous_untruncated_tab_nr_begin : s:previous_tab_nr_begin)
\   : tab_nr_begin
  let s:previous_tab_nr_end = exists("s:previous_tab_nr_end") && s:previous_tab_nr_end < tab_nr_end
\   ? (s:previous_tab_nr_end < s:previous_untruncated_tab_nr_end ? s:previous_untruncated_tab_nr_end : s:previous_tab_nr_end)
\   : tab_nr_end

  let tab_label_max_length = &columns

  let tab_label = s:GetFormattedTabLabel(tab_nr_active, tab_label_max_length, 0)
  let tab_label_max_length -= strlen(tab_label)
  let tab_line = "%" . tab_nr_active . "T%#TabLineSel#" . tab_label

  let tab_nr_range_list =
\ [
\   [tab_nr_active, s:previous_untruncated_tab_nr_begin, tab_nr_active, s:previous_untruncated_tab_nr_end],
\   [s:previous_untruncated_tab_nr_begin, s:previous_tab_nr_begin, s:previous_untruncated_tab_nr_end, s:previous_tab_nr_end],
\   [s:previous_tab_nr_begin, tab_nr_begin, s:previous_tab_nr_end, tab_nr_end]
\ ]

  for tab_nr_range in tab_nr_range_list

    for tab_nr in range(tab_nr_range[0] - 1, tab_nr_range[1], -1)
      if tab_label_max_length == 0
        let tab_line = substitute(tab_line, '^\(%[0-9]\+T%#TabLine\(Sel\)*#\).', '\1<', "")
        break
      endif

      let tab_label = s:GetFormattedTabLabel(tab_nr, tab_label_max_length, 0)
      let tab_label_max_length -= strlen(tab_label)
      let tab_line = "%" . tab_nr . "T%#TabLine#" . tab_label . tab_line

      if tab_label !~# "^<"
        let s:previous_untruncated_tab_nr_begin = tab_nr
      endif
      let s:previous_tab_nr_begin = tab_nr
    endfor

    for tab_nr in range(tab_nr_range[2] + 1, tab_nr_range[3])
      if tab_label_max_length == 0
        let tab_line = substitute(tab_line, '.$', '>', "")
        break
      endif

      let tab_label = s:GetFormattedTabLabel(tab_nr, tab_label_max_length, 1)
      let tab_label_max_length -= strlen(tab_label)
      let tab_line .= "%" . tab_nr . "T%#TabLine#" . tab_label

      if tab_label !~# ">$"
        let s:previous_untruncated_tab_nr_end = tab_nr
      endif
      let s:previous_tab_nr_end = tab_nr
    endfor

  endfor

  let tab_line .= "%#TabLineFill#"
  return tab_line
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialization

" Displays current buffer's file name and modified/modifiable indication.
set guitablabel=%t%{GetBufferModifiedChar()}
set tabline=%!GetTabLine()

" Status line for the current buffer:
"   - lhs: full path and modified/modifiable indication.
"   - rhs: [character encoding|line ending] + line,column + % through file.
set statusline=%F%1.1(%{GetBufferModifiedChar()}%)\ %=[%{GetBufferEncoding()}\|%{&fileformat}]\ %(%3.5l,%-3.4v%)\ %P
