"miniBufExpl
"function! MiniBufExpl_Setting()
"	let g:miniBufExplMapWindowNavVim = 1
"	let g:miniBufExplMapWindowNavArrows = 1
"	let g:miniBufExplMapCTabSwitchBuffs = 1
"endfunction
"call MiniBufExpl_Setting()
"let loaded_minibufexplorer=1 "無効

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
"call Neocomplcache_Setting()


