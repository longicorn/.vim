"miniBufExpl
"function! MiniBufExpl_Setting()
"	let g:miniBufExplMapWindowNavVim = 1
"	let g:miniBufExplMapWindowNavArrows = 1
"	let g:miniBufExplMapCTabSwitchBuffs = 1
"endfunction
"call MiniBufExpl_Setting()
"let loaded_minibufexplorer=1 "無効

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
