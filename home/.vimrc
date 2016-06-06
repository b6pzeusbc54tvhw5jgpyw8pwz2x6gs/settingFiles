colorscheme default

execute pathogen#infect()
syntax on
filetype plugin indent on
set nu
set ts=4
set shiftwidth=4
set background=dark
set backup
set showmatch
set ai
set smartindent
set hls
set backspace=indent,eol,start
set relativenumber
set formatoptions-=cro

map , :
map :W :w

"map ,f :mkview
"map ,l :loadview
map ,e :e./
map ,b :b#
map ㅓ j
map ㅏ k
map ㅗ h
map ㅣ l
map ㅑ i
map ㅈ w
map ㅠ b
map ㅁ a
map ,ㅈ :w

map ,m :mks!
"map ,g :set hls
"map ,gg :set nohls
vmap u y

map ;a ggVG

"Comment
"Comment Quf
map tq :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>
"Comment quf Remove
map tr :s/^\([/(]\*\\|<!--\)\(.*\)\(\*[/)]\\|-->\)$/\2/<CR><Esc>:nohlsearch<CR>

"commenT //
"map tt :s/^/\/\//<CR><Esc>:nohlsearch<CR> 
map tt :s/^\([\t ]*\)/\1\/\/<CR><Esc>:nohlsearch<CR>
"commenT //
"map tw :s/^\/\///<CR><Esc>:nohlsearch<CR> 
map tw :s/^\([\t ]*\)\/\//\1<CR><Esc>:nohlsearch<CR> 

map t< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

"Tern command
map td :TernDef<CR>
map ts :TernDefSplit<CR>
map tp :TernDefPreview<CR>
map ta :TernDefTab<CR>

"Tagbar
map to :TagbarOpen 
map tb :TernDocBrowse
map te :TernRefs
map tn :TernRename
map ty :TernType

set backupdir=~/viBackup
set dir=~/viBackup
map * #<S-N>zz
"map & /\<<c-r><c-w>\><cr><s-n>
map zl <C-w>w<C-w>w:q<CR><C-w>w<C-w>H<C-w>w<C-d>2<C-y>Hj<C-w>w

"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
set omnifunc=syntaxcomplete#Complete
set t_Co=256

"----------------------------------------------------------------------
"Open with current file's directory
function! OpenCurrentDir()
	execute ":e " . expand('%:p:h')
endfunction
map ,c :call OpenCurrentDir()<CR>
"----------------------------------------------------------------------
"A mapping to make a backup of the current file.
function! WriteBackup( attachedStr)
	silent execute 'write'
	if a:attachedStr == '0' 
		let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S')
	else
		let l:fname = &backupdir . '/' . expand('%:t') . '_' . strftime('%Y%m%d_%H.%M.%S') . '-' . a:attachedStr
	endif
	silent execute 'write' l:fname
	echomsg 'Wrote' l:fname 
endfunction

"----------------------------------------------------------------------
"SnipMate remapping
"imap <S-Tab> <Plug>snipMateNextOrTrigger
"smap <S-Tab> <Plug>snipMateNextOrTrigger
"imap '<Tab> <Plug>snipMateBack





"change numbering type
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
"----------------------------------------------------------------------
" easy-motion shortcut
map <C-i> <Plug>(easymotion-s)
map <C-h><C-i> <Plug>(easymotion-s2)
"----------------------------------------------------------------------
" c compile!!
map <Insert>g :colder<cr>
map <Insert>l :cnewer<cr>
map <Insert>n :cnext<cr>
map <Insert>p :cprevious<cr>
map <Insert>p :cprevious<cr>

"----------------------------------------------------------------------
"show path/filename status bar
function! ShowFileNameBar()
	if(&laststatus == 0 || &laststatus == 1)
	"	set statusline=%F
		set laststatus=2
	else
		set laststatus=0
	endif
endfunc

map <C-n><C-n> :call ShowFileNameBar()<cr>

"----------------------------------------------------------------------
"Using SudoEdit without gnome-ssh-askpass
:let g:sudo_no_gui=1
"----------------------------------------------------------------------
map <S-tab> <CR><C-W><C-W>

"set formatoptions-=r
"below code doesn't operate. so should revise directly related file as using floowing code to find it
":verbose set formatoptions
"setlocal fo-=t fo+=croql

"set makeprg=gcc\ -o\ $*\ $*\.o
"set makeprg=gcc\ -o\ $*\ $*\.o "-I/home/ssohjiro/GBS-ROOT/local/BUILD-ROOTS/scratch.armv7l.0/usr/include `pkg-config --cflags --libs elementary`"

"set tags=./tags,~/tagsDir/tags
"cs add ~/tagsDir/gbsRoot.out
"cs add ~/tagsDir/usrInclude.out
"cs add ./cscope.out

let g:C_CFlags="`pkg-config --cflags --libs elementary`"
let g:C_CCompiler="gcc"

"----------------------------------------------------------------------
"snippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


let b:syntastic_c_cflags='-I/home/ssohjiro/GBS-ROOT/local/BUILD-ROOTS/scratch.armv7l.0/usr/include/appfw `pkg-config --cflags --libs elementary`'
"let g:syntastic_c_include_dirs = [ 'includes', 'headers', '~/GBS-ROOT/local/BUILD-ROOTS/scratch.armv7l.0/usr/include/appfw' ]
"map <C-m><C-k> :make<CR>

"map <C-m><C-k> :!stylus %:h/%:t<CR>
map <C-m><C-k> :!lessc %:h/%:t %:r\.css<CR>

vmap <S-y> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u



"----------------------------------------------------------------------
"Fold
"set foldmethod=indent
set foldmethod=manual
set foldlevel=10
map zm :set foldlevel=1<cr>:set foldenable<cr>zz
map zr :set foldlevel+=1<cr>zz

"----------------------------------------------------------------------
"newtab
map gn :tabnew<cr>



let g:ftplugin_sql_omni_key = '<C-j>'


"let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_eslint_exec = 'eslint-project-relative'


"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.svn|node_modules|tmpStatic)$',
  \ 'file': '\v\.(exe|so|dll|png|jpg)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


" Save & backup with current time
"map ,w :w<ESC>:call WriteBackup(0)<CR>
"map ,w :call WriteBackup(0)<CR>
map ,wq :wq<cr>
map ,q :q!<cr>
map ,w :w<cr>

" Backup with current time and user string. ex) :BA successAjax!!
command! -nargs=1 BA :call WriteBackup(<f-args>)


" manual toggle paste - nopaste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


" automated toggle paste - nopaste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"80 column warning
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

map ,80 :match OverLength /\%81v.\+/
" to disable :match

