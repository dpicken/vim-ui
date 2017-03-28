""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Implementation detail

function s:MapNVOIC(lhs, rhs)
  execute "map <special> " a:lhs . " " . a:rhs
  execute "map! <special> " a:lhs . " " . a:rhs
endfunction

function s:NoRemapIfNecessary(mode_char, lhs, rhs)
  if a:rhs != ""
    execute a:mode_char . "noremap <special>" . a:lhs . " " . a:rhs
  endif
endfunction

function s:NoRemapNVOI(lhs, n_rhs, v_rhs, o_rhs, i_rhs, common_rhs)
  call s:NoRemapIfNecessary("n", a:lhs, a:n_rhs . a:common_rhs)
  call s:NoRemapIfNecessary("v", a:lhs, a:v_rhs . a:common_rhs)
  call s:NoRemapIfNecessary("o", a:lhs, a:o_rhs . a:common_rhs)
  call s:NoRemapIfNecessary("i", a:lhs, a:i_rhs . a:common_rhs)
endfunction

function s:UnmapIfNecessary(mode_char, lhs)
  if maparg(a:lhs, a:mode_char) != ""
    execute a:mode_char . "unmap " . a:lhs
  endif
endfunction

function s:UnmapNVOI(lhs)
  call s:UnmapIfNecessary("n", a:lhs)
  call s:UnmapIfNecessary("v", a:lhs)
  call s:UnmapIfNecessary("o", a:lhs)
  call s:UnmapIfNecessary("i", a:lhs)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialization

if &term =~ "xterm"
  set <F1>=[1;*P
  set <F2>=[1;*Q
  set <F3>=[1;*R
  set <F4>=[1;*S

  " XTerm (~/.Xresources)
  call s:MapNVOIC("<Esc>[1;5Z", "<C-Tab>")
  call s:MapNVOIC("<Esc>[1;2Z", "<S-Tab>")
  call s:MapNVOIC("<Esc>[1;6Z", "<C-S-Tab>")
  call s:MapNVOIC("<Esc>[1;6Y", "<C-S-Bslash>")
endif

map Q <Nop>
map q <Nop>
map Z <Nop>
map <kPlus> +
map <kMinus> -

noremap <silent> _ <Esc>:wincmd <C-R>=winnr("$") == 1 ? "_" : "T"<CR><CR>
noremap <silent> = <Esc><C-W>=
noremap <silent> + <Esc>:<C-R>=winheight(0) * 2<CR> wincmd _<CR>
noremap <silent> - <Esc>:<C-R>=winheight(0) / 2<CR> wincmd _<CR>
noremap <silent> | <Esc>:<C-R>=winwidth(0) + 2<CR> wincmd |<CR>
noremap <silent> <C-S-Bslash> <Esc>:<C-R>=winwidth(0) - 2<CR> wincmd |<CR>

vnoremap <silent> p "_dp
vnoremap <silent> P "_dP

nnoremap <silent> <C-]> :tag /\C^<C-R>=expand("<cword>")<CR>$<CR>
vnoremap <silent> <C-]> ""y<Esc>:tag /\C^<C-R>=EscapeLiteralSearchPattern(@")<CR>$<CR>
vnoremap <silent> <C-W><C-]> ""y<Esc>:tab tag /\C^<C-R>=EscapeLiteralSearchPattern(@")<CR>$<CR>

nmap <silent> <S-F1> <Plug>StlRefVimAsk
nmap <silent> <C-F1> <Plug>StlRefVimNormal
call s:NoRemapNVOI("<silent> <F2>", "", "<Esc>", "<Esc>", "<C-O>", ":call ToggleLocalOption(\"wrap\") <Bar> call <SID>NoRemapNVOI_HomeEnd()<CR>")
call s:NoRemapNVOI("<silent> <S-F2>", "", "<Esc>", "<Esc>", "<C-O>", ":call ToggleLocalOption(\"cursorcolumn\")<CR>")
call s:NoRemapNVOI("<silent> <C-F2>", "", "<Esc>", "<Esc>", "<C-O>", ":call ToggleLocalOption(\"cursorline\")<CR>")
call s:NoRemapNVOI("<silent> <C-S-F2>", "", "<Esc>", "<Esc>", "<C-O>", ":call ToggleLocalOption(\"number\")<CR>")
call s:NoRemapNVOI("<silent> <F3>", "", "<Esc>", "<Esc>", "<C-O>", ":tab cnext<CR>")
call s:NoRemapNVOI("<silent> <S-F3>", "", "<Esc>", "<Esc>", "<C-O>", ":tab cprevious<CR>")
call s:NoRemapNVOI("<silent> <C-F3>", "", "<Esc>", "<Esc>", "<C-O>", ":cc<CR>")
call s:NoRemapNVOI("<silent> <F4>", "", "", "", "", "<Esc>:call OpenSCMTool('Committool')<CR>")
call s:NoRemapNVOI("<silent> <S-F4>", "", "", "", "", "<Esc>:call OpenSCMTool('Blametool')<CR>")
call s:NoRemapNVOI("<silent> <F5>", "", "", "", "", "<Esc>:edit<CR>")
if !exists("g:ui_mappings_make")
  let g:ui_mappings_make="make --no-print-directory -C <C-R>=GetProjectPathUsingCurrentPathOrDirectory()<CR>"
endif
call s:NoRemapNVOI("<silent> <F6>", "", "", "", "", ":<Esc>:" . g:ui_mappings_make . "<CR>")
call s:NoRemapNVOI("<silent> <F7>", "", "<Esc>", "<Esc>", "<C-O>", ":call ToggleLocalOption(\"spell\")<CR>")
call s:NoRemapNVOI("<silent> <F8>", "", "<Esc>", "<Esc>", "<C-O>", ":call StripTrailingWhiteSpace()<CR>")
call s:NoRemapNVOI("<silent> <F9>", "", "<Esc>", "<Esc>", "<C-O>", ":call InsertCHeaderBoilerPlate()<CR>")
call s:NoRemapNVOI("<silent> <PageUp>", "", "<Esc>", "<Esc>", "<C-O>", "<C-U>")
call s:NoRemapNVOI("<silent> <PageDown>", "", "<Esc>", "<Esc>", "<C-O>", "<C-D>")
call s:NoRemapNVOI("<silent> <S-PageUp>", "v", "", "<Esc>v", "<C-O>v", "<C-U>")
call s:NoRemapNVOI("<silent> <S-PageDown>", "v", "", "<Esc>v", "<C-O>v", "<C-D>")
call s:NoRemapNVOI("<silent> <A-PageUp>", "", "<Esc>", "<Esc>", "<C-O>", ":tabmove <C-R>=max([tabpagenr() - 2, 0])<CR><CR>")
call s:NoRemapNVOI("<silent> <A-PageDown>", "", "<Esc>", "<Esc>", "<C-O>", ":tabmove <C-R>=tabpagenr()<CR><CR>")
call s:NoRemapNVOI("<silent> <C-A>", "<Esc>gg0v", "gg0o", "<Esc>gg0v", "<C-O>gg<C-O>0<C-O>v", "G$")
call s:NoRemapNVOI("<silent> <C-B>", "", "", "<Esc>", "<C-O>", "%")
call s:NoRemapNVOI("<silent> <C-C>", "\"+y<Right>", "\"+y", "<Esc>\"+y<Right>", "<C-O>\"+y<Right>", "")
call s:NoRemapNVOI("<silent> <C-E>", "", "", "", "", "<Esc>:call SwitchBuf(GetNextPathInCyle(resolve(expand(\"%:p\"))))<CR>")
cmap <C-E> <C-C><C-E>
call s:NoRemapNVOI("<C-F>", "", "", "", "", "<Esc>/<C-R>=expand(\"<cword>\")<CR><CR>")
vnoremap <C-F> ""y/<C-R>=EscapeLiteralSearchPattern(@")<CR><CR>
call s:NoRemapNVOI("<silent> <C-G>", "", "", "", "", "<Esc>:call FindFileAndSwitchBuf(expand(\"<cfile>\"))<CR>")
vnoremap <silent> <C-G> ""y:call FindFileAndSwitchBuf(@")<CR>
call s:NoRemapNVOI("<silent> <C-H>", "", "", "", "", "<Esc>:call OpenSCMTool('Revisiontool')<CR>")
call s:NoRemapNVOI("<silent> <C-J>", "", "", "<Esc>", "<C-O>", "<C-E>")
call s:NoRemapNVOI("<silent> <C-K>", "", "", "<Esc>", "<C-O>", "<C-Y>")
nnoremap <C-J> :tnext<CR>
nnoremap <C-K> :tprevious<CR>
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>
call s:NoRemapNVOI("<silent> <C-N>", "", "", "", "", "<Esc>:tabnew<CR>")
call s:NoRemapNVOI("<C-O>", "", "", "", "", "<Esc>:SwitchBuf <C-R>=EscapeLiteralPath(GetParentPath())<CR>")
cmap <C-O> <C-U>SwitchBuf <C-R>=EscapeLiteralPath(GetHomePath())<CR>
inoremap <C-P> <C-Y>
call s:NoRemapNVOI("<silent> <C-Q>", "", "", "", "", "<Esc>:quit<CR>")
cnoremap <C-Q> <C-C>
call s:NoRemapNVOI("<C-R>", "", "", "", "", "<Esc>:.,$substitute/<C-R>=expand(\"<cword>\")<CR>/")
vnoremap <C-R> ""y<Esc>:.,$substitute/<C-R>=EscapeLiteralSearchPattern(@")<CR>/
call s:NoRemapNVOI("<C-S>", "", "", "", "", "<Esc>:saveas <C-R>=GetCWDPath()<CR>")
cmap <C-S> <C-U>saveas <C-R>=EscapeLiteralPath(GetHomePath())<CR>
call s:NoRemapNVOI("<silent> <C-V>", "", "\"_d", "<Esc>", "<C-O>", "\"+gP")
cnoremap <C-V> <C-R>+
call s:NoRemapNVOI("<silent> <C-X>", "", "", "<Esc>", "<C-O>", "\"+x")
call s:NoRemapNVOI("<silent> <C-Y>", "", "<Esc>", "<Esc>", "<C-O>", "<C-R>")
call s:NoRemapNVOI("<silent> <C-Z>", "", "<Esc>", "<Esc>", "<C-O>", "u")
call s:NoRemapNVOI("<silent> <Tab>", ">>", ">gv", "<Esc>>>", "", "")
call s:NoRemapNVOI("<silent> <S-Tab>", "<<", "<gv", "", "<C-O><<", "")
call s:NoRemapNVOI("<silent> <C-Tab>", "", "", "", "", "<Esc>:<C-R>=winnr() == winnr(\"$\") ? \"tabnext <Bar> 1\" : \"\"<CR>wincmd w\"<CR>")
cmap <C-Tab> <C-C><C-Tab>
call s:NoRemapNVOI("<silent> <C-S-Tab>", "", "", "", "", "<Esc>:<C-R>=winnr() == 1 ? \"tabprevious <Bar> $\" : \"\"<CR>wincmd W<CR>")
cmap <C-S-Tab> <C-C><C-S-Tab>
call s:NoRemapNVOI("<silent> <Up>", "", "<Esc>", "<Esc>", "<C-O>", "gk")
call s:NoRemapNVOI("<silent> <Down>", "", "<Esc>", "<Esc>", "<C-O>", "gj")
call s:NoRemapNVOI("<silent> <C-Up>", "", "", "<Esc>", "<C-O>", "<C-Y>")
call s:NoRemapNVOI("<silent> <C-Down>", "", "", "<Esc>", "<C-O>", "<C-E>")
call s:NoRemapNVOI("<silent> <C-Left>", "", "<Esc>", "<Esc>", "<C-O>", "b")
call s:NoRemapNVOI("<silent> <C-Right>", "", "<Esc>", "<Esc>", "<C-O>", "w")
call s:NoRemapNVOI("<silent> <A-Left>", "", "<Esc>", "<Esc>", "<C-O>", ":call MoveCursorThroughCamelCase(\"Wb\")<CR>")
call s:NoRemapNVOI("<silent> <A-Right>", "", "<Esc>", "<Esc>", "<C-O>", ":call MoveCursorThroughCamelCase(\"W\")<CR>")
call s:NoRemapNVOI("<silent> <S-Up>", "v", "", "<Esc>v", "<C-O>v", "gk")
call s:NoRemapNVOI("<silent> <S-Down>", "v", "", "<Esc>v", "<C-O>v", "gj")
call s:NoRemapNVOI("<silent> <C-S-Left>", "v", "", "<Esc>v", "<C-O>v", "b")
call s:NoRemapNVOI("<silent> <C-S-Right>", "v", "", "<Esc>v", "<C-O>v", "w")
call s:NoRemapNVOI("<silent> <A-S-Left>", "v", "", "<Esc>v", "<C-O>v<Esc>", "<Esc>:call MoveCursorThroughCamelCase(\"Wb\")<CR>m`gv``")
call s:NoRemapNVOI("<silent> <A-S-Right>", "v", "", "<Esc>v", "<C-O>v<Esc>", "<Esc>:call MoveCursorThroughCamelCase(\"W\")<CR>m`gv``")
inoremap <silent> <A-S-Left> <C-O>v:<C-U>call MoveCursorThroughCamelCase("Wb")<CR><C-O>m`<C-O>gv``
inoremap <silent> <A-S-Right> <C-O>v:<C-U>call MoveCursorThroughCamelCase("W")<CR><C-O>m`<C-O>gv``
call s:NoRemapNVOI("<silent> <C-\\>", "", "", "<Esc>", "<C-O>", "<C-Z>")
call s:NoRemapNVOI("<silent> <C-@>", "", "", "", "", "<Esc>:tab tag <C-R>=expand(\"<cword>\")<CR><CR>")
vnoremap <silent> <C-@> ""y<Esc>:tab tag <C-R>=EscapeLiteralSearchPattern(@")<CR><CR>
call s:NoRemapNVOI("<silent> <C-Insert>", "i", "di", "<Esc>", "", "<C-V>")
cnoremap <C-Insert> <C-V>

function s:NoRemapNVOI_HomeEnd()
  if &wrap
    call s:NoRemapNVOI("<silent> <Home>", "", "<Esc>", "<Esc>", "<C-O>", "g<Home>")
    call s:NoRemapNVOI("<silent> <End>", "", "<Esc>", "<Esc>", "<C-O>", "g<End>")
    call s:NoRemapNVOI("<silent> <S-Home>", "v", "", "<Esc>v", "<C-O>v", "g<Home>")
    call s:NoRemapNVOI("<silent> <S-End>", "v", "", "<Esc>v", "<C-O>v", "g<End>")
  else
    call s:UnmapNVOI("<Home>")
    call s:UnmapNVOI("<End>")
    call s:UnmapNVOI("<S-Home>")
    call s:UnmapNVOI("<S-End>")
  endif
endfunction

call s:NoRemapNVOI_HomeEnd()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runtime

function s:NoRemapNVOI_CtrlS()
  " Make Ctrl-S "save" instead of "save as".
  call s:NoRemapNVOI("<buffer> <C-S>", "", "", "", "", "<Esc>:update<CR>")
endfunction

if has("autocmd")
  augroup ui_mappings
    autocmd!
    autocmd BufNewFile  * call s:NoRemapNVOI_CtrlS()
    autocmd BufFilePost * call s:NoRemapNVOI_CtrlS()
    autocmd BufReadPost * call s:NoRemapNVOI_CtrlS()
    autocmd WinEnter    * call s:NoRemapNVOI_HomeEnd()
  augroup END
endif
