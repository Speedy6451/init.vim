if has('win32')
	let g:session_dir = '%userprofile%\Desktop\workspace\programming\Vim\nvim-sessions' " specific to my PC, but who cares?
else
	let g:session_dir = '%userprofile%\Desktop\workspace\programming\Vim\nvim-sessions' " specific to my PC, but who cares?
endif

exec 'nnoremap <Leader>p :set invpaste<Enter>'
" easy pasting

:tnoremap <Esc> <C-\><C-n> " easy escape terminal (makes using vi through term impossible)

set nobackup nowritebackup " don't save those pesky ~vim files eveywhere
autocmd Filetype json syntax match Comment +\/\/.\+$+ " highlight json comments
set number " line numbers
set pyx=2 " idk why i have this
set breakindent " pretty indent
set formatoptions+="lb" " linebreak between words
set lbr " linebreak
set nocompatible " denite wanted it
filetype plugin on " denite wanted it
syntax on " denite wanted it
set termguicolors " make colors prettier
set updatetime=100 " 100 ms before backup
set showbreak=\ \ \ \ \ \ \ \  " indent wrapped lines

if has('win32') " Installs Vim-Plug
	if empty(glob('%userprofile%\AppData\Local\nvim\autoload'))
		silent !curl -fLo %userprofile%\AppData\Local\nvim\autoload\plug.vim --create-dirs 
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
else
	if empty(glob('~/.vim/plugged/plug.vim'))
		silent !curl -fLo ~/.vim/plugged/plug.vim --create-dirs 
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

call plug#begin('~/.vim/plugged') " plugins
Plug 'dracula/vim', {'as': 'dracula'} " colorscheme
Plug 'junegunn/goyo' " focus
Plug 'preservim/nerdtree' " fancy ls
Plug 'airblade/vim-gitgutter' " auto git diff
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete
Plug 'Shougo/denite.nvim', {'do' : ':UpdateRemotePlugins'}
call plug#end()

color dracula " colorscheme

autocmd FileType denite call s:denite_my_settings() " denite config
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
				\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d
				\ denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p
				\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
				\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
				\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <space>
				\ denite#do_map('toggle_select').'j'
endfunction

