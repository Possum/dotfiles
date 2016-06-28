syn on

set modeline
filetype on
filetype plugin indent on

" Make searching nicer
set incsearch
set hls

set tabpagemax=100

set t_Co=256
colorscheme desert

set sw=4 ts=4 sts=4 tw=80 ai et aw

" Work around smartindent unindenting #
inoremap # X<BS>#

" Dvorak mapping (langmap doesn't work on old vims) {{{
noremap j t
noremap t j
noremap k n
noremap n k
noremap l s
noremap s l
noremap J T
noremap T J
noremap K N
noremap N K
noremap L S
noremap S L
" }}}

" Perl syntax
let perl_include_pod = 1
let perl_extended_vars = 1

au BufNew,BufRead *.{pl,cgi,pm,t} setlocal equalprg=perltidy\ -pbp\ -l\ 80

au BufNew,BufRead *.{tt,ttml,html,ttm,htm} set ft=tt2html
au BufNew,BufRead *template*/* set ft=tt2html
au BufNew,BufRead *.pde set ft=cpp

au BufNew,BufRead *.otl colorscheme vo_dark

" Folding {{{
hi! Folded ctermbg=darkgrey ctermfg=yellow
set foldmethod=marker
let perl_fold=1
" }}}

" LaTeX-y stuf
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
au BufNew,BufRead *.{la,}tex set makeprg=pdflatex\ -interaction=nonstopmode\ %

" Skeletons {{{
augroup templates
  au!
  " read in template files
  autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/skel/skel.'.expand("<afile>:e")

  " parse special text in the templates after the read - this requires vim 7+
  autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END
" }}}

" Printer
" set pdev=Photosmart_C7200

" Hilight literal tabs and trailing whitespace {{{
    " hi! SpecialKey term=bold cterm=bold ctermfg=4 gui=bold guifg=LightBlue guibg=grey30
    hi! link SpecialKey ErrorMsg
    " set list listchars=tab:»·,trail:·,extends:>,precedes:<
    " set list lcs=trail:\ ,tab:»\ ,extends:>,precedes:<
    set list lcs=trail:\ ,tab:>\ ,extends:>,precedes:<
" }}}

" Fix bash highlighting...
let g:is_posix = 1

" Disable netrwhist generation
let g:netrw_dirhistmax = 0

" vim: sw=4 ts=4 sts=4 tw=80 ai et fdm=marker
