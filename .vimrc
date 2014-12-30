if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin()
"#call neobundle#rc(expand('~/.vim/bundle/'))
call neobundle#end()

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugins
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'vim-scripts/DrawIt'
NeoBundle 'vim-scripts/Align'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-scripts/L9'
"NeoBundle 'othree/vim-autocomplpop'
NeoBundle 'Shougo/neocomplcache.vim'

filetype on

"NeoBundleCheck
"
"for default setting
filetype plugin on
set nobackup
set incsearch
set showmatch
set nonumber
set hidden
set ruler
set list
set hlsearch
set noundofile

"nmap <Esc> <S-Space><Esc>
"Escを2回連打すると検索結果が消える
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"全角スペースのハイライト
augroup highlightDoubleByteSpace
	autocmd!
	autocmd VimEnter,Colorscheme * highlight DoubleByteSpace term=underline ctermbg=LightMagenta guibg=LightMagenta
	autocmd VimEnter,WinEnter,BufRead * match DoubleByteSpace /　/
augroup END

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
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md set filetype=markdown

function! Ruby_Setting()
	"function! RubyMethodFold(line)
	"	let line_is_method_or_end = synIDattr(synID(a:line,1,0), 'name') == 'rubyMethodBlock'
	"	let line_is_def = getline(a:line) =~ '\s*def '
	"	return line_is_method_or_end || line_is_def
	"endfunction

	set ts=2 sw=2 expandtab foldmethod=indent
	"set ts=2 sw=2 expandtab
	"set foldlevel=1
	"set foldnestmax=2
	"set ts=2 sw=2 foldexpr=RubyMethodFold(v:lnum)
endfunction
au FileType ruby call Ruby_Setting()
nnoremap <C-]> g<C-]> 

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
"let g:virtualenv_auto_activate = 1
"au FileType python call Python_Setting()

"pythonのサーチパスの表示
"function! PythonPath()
"	python import sys; print sys.path
"endfunction
"command! -bar PythonPath :call PythonPath()

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

	" 補完候補の色づけ for vim7
	hi Pmenu ctermbg=white ctermfg=black
	hi PmenuSel ctermbg=blue ctermfg=black
endfunction
call Colorschem_Setting()

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

"miniBufExpl
"function! MiniBufExpl_Setting()
"	let g:miniBufExplMapWindowNavVim = 1
"	let g:miniBufExplMapWindowNavArrows = 1
"	let g:miniBufExplMapCTabSwitchBuffs = 1
"endfunction
"call MiniBufExpl_Setting()

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
	let g:acp_enableAtStartup = 0
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_smart_case = 1
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : ''
	    \ }
endfunction
call Neocomplcache_Setting()
