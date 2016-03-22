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

