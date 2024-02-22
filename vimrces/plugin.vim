"miniBufExpl
"function! MiniBufExpl_Setting()
"	let g:miniBufExplMapWindowNavVim = 1
"	let g:miniBufExplMapWindowNavArrows = 1
"	let g:miniBufExplMapCTabSwitchBuffs = 1
"endfunction
"call MiniBufExpl_Setting() "let loaded_minibufexplorer=1 "無効

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

" LSP(Language Servers Protocol)
" 使い方space + l + <コマンド>
function! LSP_Setting()
	let g:lsp_diagnostics_enabled = 1
	"setlocal omnifunc=lsp#complete
	"setlocal signcolumn=yes
	"let g:lsp_log_file = ''
	"let g:lsp_log_verbose = 1
	"使い方
	"<space>lh : LspHover
	nnoremap [unite] <Nop>
	nmap <Space>l [unite]
	nnoremap <silent> [unite]h :LspHover<CR>
	nnoremap <silent> [unite]d :LspDefinition<CR>
	nnoremap <silent> [unite]dd :LspPeekDefinition<CR>
	nnoremap <silent> [unite]td :LspTypeDefinition<CR>
	nnoremap <silent> [unite]tdd :LspPeekTypeDefinition<CR>
	nnoremap <silent> [unite]r :LspRename<CR>
endfunction
call LSP_Setting()


" asyncomplete
" 使い方 Ctrl+nで候補を出す
function! Asyncomplete_Setting()
	"let g:asyncomplete_auto_popup = 0
	"非同期にコード補完
	"let g:lsp_async_completion = 1
	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
	inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"
endfunction
call Asyncomplete_Setting()

function! Ambiwidth_Setting()
	set ambiwidth=single
endfunction
call Ambiwidth_Setting()

"let g:tabby_trigger_mode = 'manual'
"function! Tabby_Setting()
"	filetype plugin on
"	let g:tabby_server_url = 'http://localhost:5000'
"	"let g:tabby_filetype_to_languages = {
"	"	\ "rb": "ruby",
"	"\ }
"endfunction
"call Tabby_Setting()


function! Copilot_Setting()
	filetype plugin on
	let g:copilot_proxy = 'http://localhost:5000'
endfunction
call Copilot_Setting()
