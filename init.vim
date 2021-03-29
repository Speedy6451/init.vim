if has('win32')
	let g:session_dir = $HOME .'\Desktop\workspace\programmimg\Vim\nvim-sessions' " specific to my PC, but who cares?
else
	let g:session_dir = '~/nvim/sessions' " sessions dir
endif
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><Left><Left><Left><Left><BS>' 
" save session to file

exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" load session from file

exec 'nnoremap <Leader>sd :!del ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" delete session

" TODO use plugin
silent nnoremap <Leader>ga :!git add  
" git add

silent nnoremap <Leader>gc :!git commit -m ""<left>
" git commit

silent nnoremap <Leader>gp :!git push<enter>
" git push

silent nnoremap <Leader>gpu :!git pull<enter>
" git pull

silent nnoremap <Leader>gd :!git diff<enter>
" git diff

silent nnoremap <Leader>as :AutoSaveToggle<enter>
" toggle autosave

let g:auto_save = 0
augroup ft_openscad
  au!
  au FileType openscad let b:auto_save = 1
augroup END

silent nnoremap <C-h> <C-w>h
silent nnoremap <C-j> <C-w>j
silent nnoremap <C-k> <C-w>k
silent nnoremap <C-l> <C-w>l
" split nav

silent nnoremap <C-Left> <C-w><
silent nnoremap <C-Down> <C-w>-
silent nnoremap <C-Up> <C-w>+
silent nnoremap <C-Right> <C-w>>
" split resize

silent nnoremap <Leader>n :NERDTreeToggle<enter>
" fancy ls

silent nnoremap <Leader>g :Goyo<enter>
" focus editor

silent nnoremap <Leader> b :w<Enter>:!pandoc %:t --pdf-engine=xelatex -o %:t:r.html<Enter><Enter>
" make pdf from current file

silent nnoremap <Leader>p :set invpaste<Enter>
" easy pasting

 " make cursor go down a row when line wrap.
silent nnoremap j gj
silent nnoremap k gk
" skip wrapped lines with g
silent nnoremap gj j 
silent nnoremap gk k

 " remap alt+jk to scroll
 " nnoremap 

silent vmap <leader>a :CocAction<Enter>
silent nmap <leader>a :CocAction<Enter>
" coc.vim spellcheck

silent tnoremap <Esc> <C-\><C-n> " easy escape terminal (makes using vi through term impossible)

" set nobackup nowritebackup " don't save those pesky ~vim files everywhere
set backupdir=~/.vim/backup " TODO: make this cross-platform
set directory=~/.vim/swap " probably unnecessary, not opening 8gig files.

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
set mouse=a " enable using mouse (and scroll)
set gdefault " find and replace globally by default 
set virtualedit=block " allow visual block selection out of buffer

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
Plug 'junegunn/goyo.vim' " focus
Plug 'preservim/nerdtree' " fancy ls
Plug 'airblade/vim-gitgutter' " auto git diff
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete
Plug 'Shougo/denite.nvim', {'do' : ':UpdateRemotePlugins'} " file finding
Plug 'vimwiki/vimwiki' " wiki
Plug 'jackguo380/vim-lsp-cxx-highlight' " c, c++, c# highlighting
Plug 'tpope/vim-surround' " plugin for surrounding (html good)
Plug 'tpope/vim-repeat' " plugin to make plugins work with .
Plug 'tpope/vim-fugitive' " git plugin
Plug 'tpope/vim-unimpaired' " url encoder, among others
Plug 'sirtaj/vim-openscad' " openSCAD highlighting
Plug '907th/vim-auto-save' " autosave (activate with \as)
Plug 'gustavo-hms/garbo' " scheme for vairied backgrounds
call plug#end()

color dracula " colorscheme

" ccls global config (idk bout this, only importing one header dir at a time)
" let g:coc_user_config['languageserver'].ccls.initializationOptions.clang.extraargs = '	-std=c++17'

" create coc-settings.json
if has('win32') " Installs Vim-Plug
	if empty(glob($HOME . '\AppData\Local\nvim\coc-settings.json')) " if no coc.vim config
		call writefile(["{",'"coc.preferences.noselect": false',"}"],
					\ $HOME . '\AppData\Local\nvim\coc-settings.json') " make one
		CocInstall coc-json coc-css coc-html coc-eslint coc-tsserver coc-pyright coc-stylelint coc-tslint coc-vimlsp coc-java coc-word coc-dictionary coc-spell-checker " install plugins
	endif
"else
"	if empty(glob('~/.config/nvim/coc-settings.json')) " if no coc config
"		call writefile(["{",'"coc.preferences.noselect": false',"}"],
"					\ '~/.config/nvim/coc-settings.json') " make one
"		CocInstall coc-json coc-css coc-html coc-eslint coc-tsserver coc-python coc-stylelint coc-tslint coc-vimlsp coc-java coc-word coc-dictonary coc-spell-checker " install plugins
"	endif
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
		exec 'read !dir ' . g:session_dir . '\*.vim /B /O-d /tw'
		" read sessions from new to old
	else
		exec 'read !ls -t ' g:session_dir 
	endif
	" get sessions
	normal! ggiClose
	" normal oExit
	" normal oJournal
	" normal oWiki
	normal oMenu
	normal 0gg
	" add close option
	nnoremap <Enter> :call Opensession()<Enter>
	" set mapping to select
endif

function! Opensession() " open session under cursor
	if getline(".") == "Close" " if close selected, close
		silent normal uu
		echo ""
	elseif getline(".") == "	Exit" " if exit selected, exit
		silent normal uu
		exit
	elseif getline(".") == "	Wiki" " if exit selected, exit
		silent normal uu\ww
	elseif getline(".") == "	Journal" " if exit selected, exit
		echo 'not finished'
	elseif getline(".") == "	Ev3" " if exit selected, exit
		silent normal uu
		Nread "scp://robot@ev3dev:22/balance/tools.py"
	elseif getline(".") == ""
		echo ""
	elseif getline(".") == "Menu"
		normal oExit
		normal oJournal
		normal oWiki
		normal oEv3
		normal o
		normal V4k>
		normal 2GA (Open)
		normal 0
	elseif getline(".") == "Menu (Open)"
		" normal jV3jdk
		silent normal u
	else
		let g:selected_line = getline(".") " get line under cursor
		silent normal uu
		" clear buffer

		exec 'silent !touch ' . g:session_dir. '/' . g:selected_line
		exec 'so ' . g:session_dir. '/' . g:selected_line
		" open selected session 
		nun <Enter>
		" unmap enter
	endif
endfunction


color default " temporary, so I can me HaCkErMaN with my green colorcheme.
