if has('win32')
	let g:session_dir = $HOME .'\Desktop\workspace\programming\Vim\nvim-sessions' " specific to my PC, but who cares?
else
	let g:session_dir = '~/nvim/sessions' " sessions dir
endif
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><Left><Left><Left><Left><BS>' 
" save session to file

exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" load session from file

exec 'nnoremap <Leader>sd :!del ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" delete session

exec 'nnoremap <Leader>ga :!git add '
" git add

exec 'nnoremap <Leader>gc :!git commit -m ""<left>'
" git commit

exec 'nnoremap <Leader>gp :!git push<enter>'
" git push

exec 'nnoremap <Leader>gpu :!git pull<enter>'
" git pull

exec 'nnoremap <Leader>gd :!git diff<enter>'
" git diff

exec 'nnoremap <C-h> <C-w>h'
exec 'nnoremap <C-j> <C-w>j'
exec 'nnoremap <C-k> <C-w>k'
exec 'nnoremap <C-l> <C-w>l'
" split nav

exec 'nnoremap <C-Left> <C-w><'
exec 'nnoremap <C-Down> <C-w>-'
exec 'nnoremap <C-Up> <C-w>+'
exec 'nnoremap <C-Right> <C-w>>'
" split resize

exec 'nnoremap <Leader>n :NERDTreeToggle<enter>'
" fancy ls

exec 'nnoremap <Leader>g :Goyo<enter>'
" focus editor

exec 'nnoremap <Leader> b :w<Enter>:!pandoc %:t --pdf-engine=xelatex -o %:t:r.html<Enter><Enter>'
" make pdf from current file

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
	if empty(glob($HOME . '\AppData\Local\nvim\autoload'))
		exec 'silent !curl -fLo ' . $HOME . '\AppData\Local\nvim\autoload\plug.vim --create-dirs '
					\ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
Plug 'Shougo/denite.nvim', {'do' : ':UpdateRemotePlugins'} " file finding
Plug 'vimwiki/vimwiki' " wiki
call plug#end()

color dracula " colorscheme

" create coc-settings.json
if has('win32') " Installs Vim-Plug
	if empty(glob($HOME . '\AppData\Local\nvim\coc-settings.json')) " if no coc.vim config
		call writefile(["{",'"coc.preferences.noselect": false',"}"],
					\ $HOME . '\AppData\Local\nvim\coc-settings.json') " make one
		CocInstall coc-json coc-css coc-html coc-eslint coc-tsserver coc-python coc-stylelint coc-tslint coc-vimlsp coc-java coc-word coc-dictonary coc-spell-checker " install plugins
	endif
else
	if empty(glob('~/.config/nvim/coc-settings.json')) " if no coc config
		call writefile(["{",'"coc.preferences.noselect": false',"}"],
					\ '~/.config/nvim/coc-settings.json') " make one
		CocInstall coc-json coc-css coc-html coc-eslint coc-tsserver coc-python coc-stylelint coc-tslint coc-vimlsp coc-java coc-word coc-dictonary coc-spell-checker " install plugins
	endif
endif

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

if empty(argv()) " if nvim opened with no args
	if has("win32")
		exec 'read !dir ' . g:session_dir
	else
		exec 'read !ls ' g:session_dir 
	endif
	" get sessions
	normal! ggiClose
	normal 0
	" add close option
	nnoremap <Enter> :call Opensession()<Enter>
	" set mapping to select
endif

function! Opensession() " open session under cursor
	if getline(".") == "Close" " if close selected, close
		normal u
	else
		let g:selected_line = getline(".") " get line under cursor
		normal u
		" clear buffer
		exec 'so ' . g:session_dir. '/' . g:selected_line
		" open selected session
		nun <Enter>
		" unmap enter
	endif
endfunction
