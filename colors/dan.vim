" Vim color file

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "dan"

" GUI
highlight Normal        guifg=#b0b0b0       guibg=#000000     gui=none
highlight Cursor        guifg=bg            guibg=#00ff00     gui=none
highlight CursorColumn  guifg=NONE          guibg=#404040     gui=none
highlight CursorLine    guifg=NONE          guibg=#404040     gui=none
highlight DiffAdd       guifg=#8080c0       guibg=bg          gui=none
highlight DiffDelete    guifg=#800000       guibg=bg          gui=none
highlight DiffChange    guifg=#8080c0       guibg=bg          gui=none
highlight DiffText      guifg=#8080c0       guibg=bg          gui=none
highlight MatchParen    guifg=NONE          guibg=#404040     gui=none
highlight Visual        guifg=fg            guibg=#4040c0     gui=none
highlight VisualNOS     guifg=bg            guibg=fg          gui=none
highlight Search        guifg=fg            guibg=#4040c0     gui=none
highlight IncSearch     guifg=fg            guibg=#4040c0     gui=none
highlight WildMenu      guifg=#4040c0       guibg=#ffffff     gui=none
highlight StatusLine    guifg=#ffffff       guibg=#4040c0     gui=none
highlight StatusLineNC  guifg=bg            guibg=#8080c0     gui=none
highlight VertSplit     guifg=bg            guibg=#8080c0     gui=none
highlight TabLine       guifg=bg            guibg=#8080c0     gui=none
highlight TabLineFill   guifg=NONE          guibg=#8080c0     gui=none
highlight TabLineSel    guifg=#ffffff       guibg=#4040c0     gui=none
highlight Pmenu         guifg=bg            guibg=#8080c0     gui=none
highlight PmenuSel      guifg=#ffffff       guibg=#4040c0     gui=none
highlight PmenuSbar     guifg=NONE          guibg=#8080c0     gui=none
highlight PmenuThumb    guifg=NONE          guibg=#4040c0     gui=none
highlight LineNr        guifg=#8080a0       guibg=#101010     gui=none
highlight NonText       guifg=#8080a0       guibg=#101010     gui=none
highlight Folded        guifg=#8080a0       guibg=#101010     gui=none
highlight FoldColumn    guifg=#8080a0       guibg=#101010     gui=none
highlight SignColumn    guifg=#8080a0       guibg=#101010     gui=none
highlight SpellBad      guisp=#c04040                         gui=undercurl
highlight SpellCap      guisp=#c04040                         gui=undercurl
highlight SpellLocal    guisp=#c04040                         gui=undercurl
highlight SpellRare     guisp=#c04040                         gui=undercurl

highlight Question      guifg=#40ff40       guibg=bg          gui=bold
highlight MoreMsg       guifg=#40ff40       guibg=bg          gui=bold
highlight ModeMsg       guifg=fg            guibg=bg          gui=bold
highlight WarningMsg    guifg=#ff0000       guibg=bg          gui=bold
highlight ErrorMsg      guifg=#ffffff       guibg=#ff0000     gui=bold

highlight Error         guifg=fg            guibg=#c04040     gui=none
highlight SpecialKey    guifg=#c04040       guibg=bg          gui=none
highlight Special       guifg=#8080c0       guibg=bg          gui=none
highlight Title         guifg=#8080c0       guibg=bg          gui=none
highlight Directory     guifg=#8080c0       guibg=bg          gui=none
highlight Statement     guifg=#8080c0       guibg=bg          gui=none
highlight Type          guifg=#8080c0       guibg=bg          gui=none
highlight Identifier    guifg=#8080c0       guibg=bg          gui=none
highlight PreProc       guifg=#8080c0       guibg=bg          gui=none
highlight Underlined    guifg=#8080c0       guibg=bg          gui=underline
highlight Constant      guifg=#b080b0       guibg=bg          gui=none
highlight Comment       guifg=#007040       guibg=bg          gui=italic
highlight Todo          guifg=bg            guibg=#007040     gui=italic
highlight Ignore        guifg=bg            guibg=bg          gui=none

" Console
if &t_Co == 256
  highlight Normal        ctermfg=249         ctermbg=Black       cterm=none
  highlight Cursor        ctermfg=bg          ctermbg=Green       cterm=bold
  highlight CursorColumn  ctermfg=NONE        ctermbg=238         cterm=none
  highlight CursorLine    ctermfg=NONE        ctermbg=238         cterm=none
  highlight DiffAdd       ctermfg=104         ctermbg=bg          cterm=none
  highlight DiffDelete    ctermfg=124         ctermbg=bg          cterm=none
  highlight DiffChange    ctermfg=104         ctermbg=bg          cterm=none
  highlight DiffText      ctermfg=104         ctermbg=bg          cterm=none
  highlight MatchParen    ctermfg=NONE        ctermbg=238         cterm=none
  highlight Visual        ctermfg=fg          ctermbg=61          cterm=none
  highlight VisualNOS     ctermfg=bg          ctermbg=fg          cterm=none
  highlight Search        ctermfg=fg          ctermbg=61          cterm=none
  highlight IncSearch     ctermfg=fg          ctermbg=61          cterm=none
  highlight WildMenu      ctermfg=61          ctermbg=White       cterm=none
  highlight StatusLine    ctermfg=White       ctermbg=61          cterm=none
  highlight StatusLineNC  ctermfg=bg          ctermbg=146         cterm=none
  highlight VertSplit     ctermfg=bg          ctermbg=146         cterm=none
  highlight TabLine       ctermfg=bg          ctermbg=146         cterm=none
  highlight TabLineFill   ctermfg=NONE        ctermbg=146         cterm=none
  highlight TabLineSel    ctermfg=White       ctermbg=61          cterm=none
  highlight Pmenu         ctermfg=bg          ctermbg=146         cterm=none
  highlight PmenuSel      ctermfg=White       ctermbg=61          cterm=none
  highlight PmenuSbar     ctermfg=NONE        ctermbg=146         cterm=none
  highlight PmenuThumb    ctermfg=NONE        ctermbg=61          cterm=none
  highlight LineNr        ctermfg=145         ctermbg=235         cterm=none
  highlight NonText       ctermfg=145         ctermbg=235         cterm=none
  highlight Folded        ctermfg=145         ctermbg=235         cterm=none
  highlight FoldColumn    ctermfg=145         ctermbg=235         cterm=none
  highlight SignColumn    ctermfg=145         ctermbg=235         cterm=none
  highlight SpellBad      ctermfg=167         ctermbg=bg          cterm=undercurl
  highlight SpellCap      ctermfg=167         ctermbg=bg          cterm=undercurl
  highlight SpellLocal    ctermfg=167         ctermbg=bg          cterm=undercurl
  highlight SpellRare     ctermfg=167         ctermbg=bg          cterm=undercurl

  highlight Question      ctermfg=Green       ctermbg=bg          cterm=bold
  highlight MoorMsg       ctermfg=Green       ctermbg=bg          cterm=bold
  highlight ModeMsg       ctermfg=fg          ctermbg=bg          cterm=bold
  highlight WarningMsg    ctermfg=196         ctermbg=bg          cterm=bold
  highlight ErrorMsg      ctermfg=White       ctermbg=196         cterm=bold

  highlight Error         ctermfg=fg          ctermbg=167         cterm=none
  highlight SpecialKey    ctermfg=167         ctermbg=bg          cterm=none
  highlight Special       ctermfg=104         ctermbg=bg          cterm=none
  highlight Title         ctermfg=104         ctermbg=bg          cterm=none
  highlight Directory     ctermfg=104         ctermbg=bg          cterm=none
  highlight Statement     ctermfg=104         ctermbg=bg          cterm=none
  highlight Type          ctermfg=104         ctermbg=bg          cterm=none
  highlight Identifier    ctermfg=104         ctermbg=bg          cterm=none
  highlight PreProc       ctermfg=104         ctermbg=bg          cterm=none
  highlight Underlined    ctermfg=104         ctermbg=bg          cterm=underline
  highlight Constant      ctermfg=139         ctermbg=bg          cterm=none
  highlight Comment       ctermfg=29          ctermbg=bg          cterm=none
  highlight Todo          ctermfg=bg          ctermbg=29          cterm=none
  highlight Ignore        ctermfg=bg          ctermbg=bg          cterm=none
else
  highlight Normal        ctermfg=LightGrey   ctermbg=Black       cterm=none
  highlight Cursor        ctermfg=bg          ctermbg=Green       cterm=bold
  highlight CursorColumn  ctermfg=bg          ctermbg=LightGrey   cterm=none
  highlight CursorLine    ctermfg=bg          ctermbg=LightGrey   cterm=none
  highlight DiffAdd       ctermfg=DarkGreen   ctermbg=bg          cterm=none
  highlight DiffDelete    ctermfg=DarkRed     ctermbg=bg          cterm=none
  highlight DiffChange    ctermfg=DarkGreen   ctermbg=bg          cterm=none
  highlight DiffText      ctermfg=DarkGreen   ctermbg=bg          cterm=none
  highlight MatchParen    ctermfg=NONE        ctermbg=LightGrey   cterm=none
  highlight Visual        ctermfg=fg          ctermbg=DarkBlue    cterm=none
  highlight VisualNOS     ctermfg=bg          ctermbg=fg          cterm=none
  highlight Search        ctermfg=fg          ctermbg=DarkBlue    cterm=none
  highlight IncSearch     ctermfg=fg          ctermbg=DarkBlue    cterm=none
  highlight WildMenu      ctermfg=DarkBlue    ctermbg=White       cterm=none
  highlight StatusLine    ctermfg=White       ctermbg=DarkBlue    cterm=none
  highlight StatusLineNC  ctermfg=bg          ctermbg=Grey        cterm=none
  highlight VertSplit     ctermfg=bg          ctermbg=Grey        cterm=none
  highlight TabLine       ctermfg=bg          ctermbg=Grey        cterm=none
  highlight TabLineFill   ctermfg=NONE        ctermbg=Grey        cterm=none
  highlight TabLineSel    ctermfg=White       ctermbg=DarkBlue    cterm=none
  highlight Pmenu         ctermfg=bg          ctermbg=Grey        cterm=none
  highlight PmenuSel      ctermfg=White       ctermbg=DarkBlue    cterm=none
  highlight PmenuSbar     ctermfg=NONE        ctermbg=Grey        cterm=none
  highlight PmenuThumb    ctermfg=NONE        ctermbg=DarkBlue    cterm=none
  highlight LineNr        ctermfg=Grey        ctermbg=DarkGrey    cterm=none
  highlight NonText       ctermfg=Grey        ctermbg=DarkGrey    cterm=none
  highlight Folded        ctermfg=Grey        ctermbg=DarkGrey    cterm=none
  highlight FoldColumn    ctermfg=Grey        ctermbg=DarkGrey    cterm=none
  highlight SignColumn    ctermfg=Grey        ctermbg=DarkGrey    cterm=none
  highlight SpellBad      ctermfg=DarkRed     ctermbg=bg          cterm=undercurl
  highlight SpellCap      ctermfg=DarkRed     ctermbg=bg          cterm=undercurl
  highlight SpellLocal    ctermfg=DarkRed     ctermbg=bg          cterm=undercurl
  highlight SpellRare     ctermfg=DarkRed     ctermbg=bg          cterm=undercurl

  highlight Question      ctermfg=Green       ctermbg=bg          cterm=bold
  highlight MoorMsg       ctermfg=Green       ctermbg=bg          cterm=bold
  highlight ModeMsg       ctermfg=fg          ctermbg=bg          cterm=bold
  highlight WarningMsg    ctermfg=Red         ctermbg=bg          cterm=bold
  highlight ErrorMsg      ctermfg=White       ctermbg=Red         cterm=bold

  highlight Error         ctermfg=fg          ctermbg=DarkRed     cterm=none
  highlight SpecialKey    ctermfg=DarkRed     ctermbg=bg          cterm=none
  highlight Special       ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Title         ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Directory     ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Statement     ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Type          ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Identifier    ctermfg=Blue        ctermbg=bg          cterm=none
  highlight PreProc       ctermfg=Blue        ctermbg=bg          cterm=none
  highlight Underlined    ctermfg=Blue        ctermbg=bg          cterm=underline
  highlight Constant      ctermfg=DarkMagenta ctermbg=bg          cterm=none
  highlight Comment       ctermfg=DarkGreen   ctermbg=bg          cterm=none
  highlight Todo          ctermfg=bg          ctermbg=DarkGreen   cterm=none
  highlight Ignore        ctermfg=bg          ctermbg=bg          cterm=none
endif
