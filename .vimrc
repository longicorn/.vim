"pthogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

"for default setting
set nobackup
set incsearch
set showmatch
set nonumber
set hidden
set ruler
set list
set hlsearch

"Escを2回連打すると検索結果が消える
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"set expandtab	"for tab is space
syntax on
filetype on
filetype indent on
filetype plugin on

" 改行コード自動認識
set fileformats=unix,dos,mac

"for vimdiffの分割方法
set diffopt=vertical
"逆に水平分割にしたければ以下を設定する。
"set diffopt=horizontal

"for language
function! Ruby_Setting()
	set ts=2 sw=2 expandtab
endfunction
au FileType ruby call Ruby_Setting()

function! Python_Setting()
	set ts=4 sw=4 expandtab foldmethod=indent

	"for ropevim
	if exists("g:loaded_rope")
		nnoremap [rope] <Nop>
		vnoremap [vrope] <Nop>
		nmap <Space>r [rope]
		vmap <Space>r [vrope]
		nnoremap <silent> [rope]r :RopeRename<CR>
		nnoremap <silent> [rope]u :RopeUndo<CR>
		"メソッド切り出し
		vnoremap <silent> [vrope]f :RopeExtractMethod<CR>
	endif
endfunction
"for virtualenv
"Python_Setting()でletしても意味なし
let g:virtualenv_auto_activate = 1
au FileType python call Python_Setting()

"pythonのサーチパスの表示
function! PythonPath()
	python import sys; print sys.path
endfunction
command! -bar PythonPath :call PythonPath()

" for colorschem
function! Colorschem_Setting()
	"colorscheme default
	"colorscheme ron
	"colorscheme murphy
	"colorscheme evening
	"colorscheme morning

	"colorscheme elflord
	"colorscheme peachpuff
	"colorscheme delek

	"colorscheme zellner

	"colorscheme darkblue
	"colorscheme desert
	"colorscheme koehler
	"colorscheme pablo
	"colorscheme shine

	"colorscheme torte
	"colorscheme blue

	colorscheme hhspring
	"colorscheme earth
	"colorscheme jhlight

	"colorscheme bw
endfunction
call Colorschem_Setting()

" 補完候補の色づけ for vim7
"hi Pmenu ctermbg=7
"hi PmenuSel ctermbg=12
"hi PmenuSbar ctermbg=15
"hi Pmenu ctermbg=Gray
"hi PmenuSel ctermbg=Red
"hi PmenuSbar ctermbg=White


" under etc setting
" --------------------

"for encoding
" 文字コード自動認識
function! Auto_Encodeing_Setting()
	if &encoding !=# 'utf-8'
		set encoding=japan
		set fileencoding=japan
	endif
	if has('iconv')
		let s:enc_euc = 'euc-jp'
		let s:enc_jis = 'iso-2022-jp'
		" iconvがeucJP-msに対応しているかをチェック
		if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
			let s:enc_euc = 'eucjp-ms'
			let s:enc_jis = 'iso-2022-jp-3'
			" iconvがJISX0213に対応しているかをチェック
		elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
			let s:enc_euc = 'euc-jisx0213'
			let s:enc_jis = 'iso-2022-jp-3'
		endif
		" fileencodingsを構築
		if &encoding ==# 'utf-8'
			let s:fileencodings_default = &fileencodings
			let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
			let &fileencodings = &fileencodings .','. s:fileencodings_default
			unlet s:fileencodings_default
		else
			let &fileencodings = &fileencodings .','. s:enc_jis
			set fileencodings+=utf-8,ucs-2le,ucs-2
			if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
				set fileencodings+=cp932
				set fileencodings-=euc-jp
				set fileencodings-=euc-jisx0213
				set fileencodings-=eucjp-ms
				let &encoding = s:enc_euc
				let &fileencoding = s:enc_euc
			else
				let &fileencodings = &fileencodings .','. s:enc_euc
			endif
		endif
		" 定数を処分
		unlet s:enc_euc
		unlet s:enc_jis
	endif
endfunction

if has("autocmd")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif " has("autocmd")

autocmd BufWritePost * :call AddExecmod()
function AddExecmod()
    let line = getline(1)
    if strpart(line, 0, 2) == "#!"
        call system("chmod +x ". expand("%"))
    endif
endfunction

"vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | silent %!xxd -g 1
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | silent %!xxd -g 1
  au BufWritePost *.bin set nomod | endif
augroup END

"ChangeLog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "yasusi "


" under plugin setting
" --------------------

"map <F1> p
" 1line comments
" このコマンドを使用する場合はC-v後に各コマンドを使用してください
" for C++ command: ,/
" for vim script " command: ,"
" for del above comments use:,c

" wrapping comments
" C C++ /**/ /**/ /**/ command: ,*
" vim del above comments command: ,d

" block comments command: ,b
"for C C++ /*    */

"miniBufExpl
function! MiniBufExpl_Setting()
	let g:miniBufExplMapWindowNavVim = 1
	let g:miniBufExplMapWindowNavArrows = 1
	let g:miniBufExplMapCTabSwitchBuffs = 1
endfunction
call MiniBufExpl_Setting()

"map <C-n> :cn<CR>
"map <C-p> :cp<CR>
"map ^? :GtagsCursor<CR> "(^?はC-v + C-8)
"map ^_ :Gtags -r ^R^W<CR> "(^_はC-v + C-7、 ^R,^WはC-v + C-R/C-W)

" unite
function! Unite_Setting()
	nnoremap [unite] <Nop>
	nmap <Space>f [unite]
	"ファイル一覧
	nnoremap <silent> [unite]f :Unite file<CR>
	"ファイル一覧
	nnoremap <silent> [unite]c :UniteWithBufferDir -buffer-name=files file<CR>
	"最近使ったファイルの一覧
	noremap [unite]l :Unite file_mru<CR>
	"ブックマーク一覧
	nnoremap <silent> [unite]b :<C-u>Unite bookmark<CR>
	"ブックマークに追加
	nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
endfunction
call Unite_Setting()

" neocomplcache
function! Neocomplcache_Setting()
	let g:neocomplcache_enable_at_startup = 1
endfunction
call Neocomplcache_Setting()

" local_vimrc
function! Neocomplcache_Setting()
	"let g:local_vimrc = 1
	let g:localvimrc_ask = 0
	let g:localvimrc_sandbox = 0
endfunction
call Neocomplcache_Setting()

" Auto Complete PopUp
function! AutoComplPop_Setting()
	inoremap ,s <ESC>:AutoComplPopDisable<CR>a
	inoremap ,q <ESC>:AutoComplPopEnable<CR>a
	nnoremap ,s :AutoComplPopDisable<CR>
	nnoremap ,q :AutoComplPopEnable<CR>
	"let g:AutoComplPop_NotEnableAtStartup=1
endfunction
call AutoComplPop_Setting()

"inoremap \sc ShowScratchBuffer
"inoremap \sc InsShowScratchBuffer

""自動補完候補表示
"" Thanks ns9tks
"" http://subtech.g.hatena.ne.jp/cho45/20071009#c1191925480
"set completeopt=menuone,preview
"function! CompleteWithoutInsert()
"        return "\<C-n>\<C-r>=pumvisible() ? \"\\<C-P>\\<C-N>\\<C-P>\": \"\"\<CR>"
"endfunction
"inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : CompleteWithoutInsert()
"" 小文字入力で常にメニューだす
"let letter = "a"
"while letter <=# "z"
"        execute 'inoremap <expr> ' letter ' "' . letter . '" . (pumvisible() ? "" : CompleteWithoutInsert())'
"        let letter = nr2char(char2nr(letter) + 1)
"endwhile
"inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"
"inoremap . .<ESC>a
"inoremap ( (<ESC>a
"inoremap [ [<ESC>a
"set lazyredraw

"set for YankRing
"set viminfo+=! 

"set for savevers.vim
"set backup
"set patchmode=.clean
"let savevers_types = "*.c,*.h"
"let savevers_dirs = &backupdir
"let versdiff_no_resize=1
"nmap <silent> <F5> :VersDiff -<cr>
"nmap <silent> <F6> :VersDiff +<cr>
"nmap <silent> <F8> :VersDiff -c<cr>

"set for mru.vim
"let MRU_Window_Height=6
