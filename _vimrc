set nocompatible
colors murphy
"colors desert
"colors torte
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"set nobackup " in vimrc_example.vim file there is a test structure 
"
" to determine whether to set backup.
set backupdir=$VIMRUNTIME\..\backup " where to put backup file
set directory='$VIMRUNTIME\..\tmp' " directory is the directory for temp file
behave mswin
set smarttab
set nohlsearch


syntax enable
filetype plugin indent on


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" latex configuration
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"
"
"Added by Chao Liu on 14/04/2013
"let g:winManagerWindowLayout = "FileExplorer" 
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
nmap wm :WMToggle


"Added by Chao Liu on 15/04/2013
"Set the default swap file directory.
set directory=c:/temp,c:/tmp
" mapping shift+enter as input a blank line preceeding the current line 
" and enter as input a blank line after the current line
map <S-Enter> O<Esc>j
map <CR> o<Esc>k

" Added on 13 Jun,2013
set nu
" added on 25 aug, 2013
" when a new file is opened, vim will guess the coding style with the coding
" style in the following list. Then the fileencoding value is set by this
" style. Encoding style of a file can be showed by typing 'set fileencoding'
" in the command mode.
set fileencodings=utf-8,gb2312,gbk,utf-16,big5
set encoding=utf-8
" for titlebar diaplay problem
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language message zh_CN.UTF-8

" added on 21 Sep. 2013
"
" centralize the line and capitalize the first letter in every word

function! CapitalizeCenterAndMoveDown()
   s/\<./\u&/g   "Built-in substitution capitalizes each word
   center        "Built-in center command centers entire line
   +1            "Built-in relative motion (+1 line down)
endfunction

nmap <silent>  \C  :call CapitalizeCenterAndMoveDown()<CR>
" added on 20 Sep, 2013
" General header for programming and scripting
map <BS>h o author: Chao Liu<CR>copyright: <CR>credits: <CR>license: <CR>version: <CR>maintainer: <CR>email: liuchaotju@gmail.com<CR>status: <CR>
"  added on Oct 29, 2013
" tabstop and shiftwidth(auto indent at hierarchy)
" someone prefers 4
set sw=2 
set ts=2

"  added on Nov 9, 2013
"  dictionary setup
"
set dictionary="D:\Program Files\Vim\vim73\usr_share_dict\words"

"  added on Nov 9, 2013
"  colorful maker of column boundary
"
" set colorcolumn=80 
" 
set dictionary+="D:/Program Files/Vim/vim74/usr_share_dict/words"

" added on Nov 12, 2013
"
map <BS>l ':e E:\script\shell\UsefulShellCML.sh'
"
" added on Dec 21, 2013
" copy the entire filename and path of current file to system clipboard
command! Copyfile let @*=substitute(expand("%:p"), '/', '\', 'g')

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on
   
" added on Dec 27, 2013
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
   
  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
   
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:?\ ,eol:?

" added on Dec 28, 2013
" mimite the windows C-c C-v copy and paste behaviour in visual mode
"
vnoremap <C-c> "*y
"vnoremap <C-v> "*p 

" added on Dec 28, 2013
" set gvim font. In linux the font of vim in terminal is determined by system
" setting, however in gvim you can specify your own font
"
set guifont=DejaVu\ Sans\ Mono:h8
" in linux the syntax is courier_new\ 4
" 									^^
"notice the colon is replaced by backslash and there is	a space after the backslash
"
function! GenerateUnicode(first, last)
" this function is used to generate the unicode character in the range
" first and last. first and last argument should in the form of 0xXXXX
  let i = a:first
  while i <= a:last
    if (i%256 == 0)
      $put ='----------------------------------------------------'
      $put ='     0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F '
      $put ='----------------------------------------------------'
    endif
    let c = printf('%04X ', i)
    for j in range(16)
      let c = c . nr2char(i) . ' '
      let i += 1
    endfor
    $put =c
  endwhile
endfunction

" added on Dec 31, 2013
" disable the Alt menu function
set winaltkeys=no
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" added on Jan 21, 2014
" pathogen related configuration
"
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" added on Feb 08, 2014
" Programmings abbrevs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ab xif if ( ) {<return><return>}<up><up><end><left><left><left><left>
ab xelsif elsif ( ) {<return><return>}<up><up><end><left><left><left><left>
ab xelse else {<return><return>}<up><home><space><space><space>
ab xfor for ( ) {<return><return>}<up><up><end><left><left><left><left>
ab xforeach foreach ( ) {<return><return>}<up><up><end><left><left><left><left><left><left>
ab xwhile while ( ) {<return><return>}<up><up><end><left><left><left><left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" added on Feb 28, 2014
" for chinese line wrap.
" long chinese sentences without whitespace would be regarded by vim as single
" character which leads to the auto line wrap mulfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set formatoptions+=tmM 
" the 't' option here is turn on the auto wrap function, namely the hard wrap.
" there is also soft wrap which is the 'wrap' option. when the 'set wrap' is
" applied, the text displayed in the terminal is with no line breaks

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" added on Mar 05, 2014
" map
" character which leads to the auto line wrap mulfunction
map! jj <ESC>

