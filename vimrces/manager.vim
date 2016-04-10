if &compatible
  set nocompatible
endif
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')
"call dein#add('Shougo/neocomplete.vim')
call dein#add('fholgado/minibufexpl.vim')
call dein#add('Shougo/unite.vim')
call dein#add('vim-scripts/DrawIt')
call dein#add('vim-scripts/Align')
call dein#add('jamessan/vim-gnupg.git')
call dein#add('yuratomo/w3m.vim')
call dein#add('toyamarinyon/vim-swift')
call dein#add('tpope/vim-surround') " S'とかで囲める
call dein#add('itchyny/vim-cursorword') " カーソルの下の変数に下線表示

"NeoBundle 'vim-scripts/L9'
"NeoBundle 'motemen/hatena-vim'
"NeoBundle 'scrooloose/nerdcommenter' " ccでコメントアウト

call dein#end()
