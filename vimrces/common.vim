"for default setting
filetype on
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

"ChangeLog
let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_username = "yasusi "

"
" userの拡張設定
"

"nmap <Esc> <S-Space><Esc>
"Escを2回連打すると検索結果が消える
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"space x 2で行選択
nmap <Space><Space> V

"escapeでime off linux
if has('unix')
	function! ImInActivate()
		call system('fcitx-remote -c')
	endfunction
	inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>
endif

"全角スペースのハイライト
augroup highlightDoubleByteSpace
	autocmd!
	autocmd VimEnter,Colorscheme * highlight DoubleByteSpace term=underline ctermbg=LightMagenta guibg=LightMagenta
	autocmd VimEnter,WinEnter,BufRead * match DoubleByteSpace /　/
augroup END

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

" alcで単語翻訳
" need w3m.vim
" close :bd
function! Alc_Setting()
	function! Alc(word)
	  let reg = @"
	  let @" = ':W3m ' . 'http://eow.alc.co.jp/search?q=' .  a:word
	  :execute @"
	  let @" = reg
	endfunction
	
	function! WAlc()
	  let word = expand("<cword>")
	  call Alc(word)
	endfunction
	
	function! VAlc()
	  let word = @"
	  call Alc(word)
	endfunction
	nmap <Space>alc :call WAlc()<CR>
	vmap <Space>alc y :call VAlc()<CR>
endfunction
call Alc_Setting()

"camel case <=> snake case
function! SwapCase_Setting()
	function! SnakeCamel()
	  let reg = @"
	  let @" = ':s/^\(.\)/\u\1/e'
	  :execute @"
	  let @" = ':s/_\(.\)/\u\1/ge'
	  :execute @"
	  let @" = reg
	endfunction

	function! CamelSnake()
	  let reg = @"
	  let @" = ':s/^\(.\)/\l\1/e'
	  :execute @"
	  let @" = ':s/\([A-Z]\)/_\l\1/ge'
	  :execute @"
	  let @" = reg
	endfunction
	"Swap Case to Camel case
	nmap <Space>scc :call SnakeCamel()<CR>
	nmap <Space>scs :call CamelSnake()<CR>
endfunction
call SwapCase_Setting()
