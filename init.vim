if has('win32')
	let g:session_dir = $HOME .'\Desktop\workspace\programmimg\Vim\nvim-sessions' " specific to my PC, but who cares?
else
	let g:session_dir = '~/.vim/sessions' " sessions dir
endif
exec 'nnoremap <Leader>ss :NERDTreeClose<Enter>:mks! ' . g:session_dir . '/*<C-D><BS>' 
" save session to file

exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*<C-D><BS>'
" load session from file

exec 'nnoremap <Leader>sd :!del ' . g:session_dir. '/*<C-D><BS>'
" delete session

let g:auto_save = 0
augroup ft_openscad " auto save on scad files by default so live preview will work
  au!
  au FileType openscad let b:auto_save = 1
augroup END

"augroup toml " TODO: get real toml highlighting (COC?)
"    au!
"    autocmd FileType BufNewFile,BufRead *.toml set syntax=javascript
"augroup END

" au BufRead,BufNewFile *.toml setfiletype javascript

silent nmap s ^C
" replace current line

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" jump to various

" use space or \
exec 'nmap <Space> <Leader>'
exec 'vmap <Space> <Leader>'

nnoremap <leader>w :w<enter>

" end paste at bottom of selection
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nmap <leader>r <Plug>(coc-rename)
"vmap <leader>r <Plug>(coc-refactor)
" refactor

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" formt

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" show docs on K

nnoremap <leader>l :call DmenuFzf()<cr>

function! DmenuFzf() " heavily inspired by https://leafo.net/posts/using_dmenu_to_open_quickly.html
    let name= system("git ls-files | dmenu -i -l 32 -p edit | tr -d '\n'")
    if empty(name)
        return
    endif
    execute "edit " . name
endfunction

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" CoC sub-pane scroll

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

silent nnoremap <Leader>e :ToggleTerm<enter>
" fancy ls

silent nnoremap <Leader>n :NERDTreeToggle<enter>
" fancy ls

silent nnoremap <Leader>t :UndotreeToggle<enter>

let g:goyo_width = '75%'

silent nnoremap <Leader>g :Goyo<enter>
" focus editor

silent nnoremap <Leader>b :w<Enter>:!pandoc %:t --pdf-engine=xelatex -o %:t:r.html<Enter><Enter>
" make pdf from current file

silent nnoremap <Leader>p :set invpaste<Enter>
" disable autoformatting so pasted code looks right

silent nnoremap <Leader>c :set rnu!<Enter>
" relative line number toggle on c

 " keep cursor from skipping wrapped lines
silent nnoremap j gj
silent nnoremap k gk
" skip wrapped lines with g
silent nnoremap gj j 
silent nnoremap gk k

 " remap alt+jk to scroll TODO
 " nnoremap 

silent vmap <leader>a <Plug>(coc-codeaction-selected)
" silent nmap <leader>a <Plug>(coc-codeaction-line)
silent nmap <leader>a <Plug>(coc-codeaction-cursor)
" coc.vim spellcheck and refactoring

silent tnoremap <Esc> <C-\><C-n> 
" easy escape terminal (at the expense of using vi in a subterm)

" set nobackup nowritebackup " don't save those pesky ~vim files everywhere
set backupdir=~/.vim/backup " save backup files outside of current dir TODO: make this cross-platform
set directory=~/.vim/swap " probably unnecessary, not opening 8gig files.
set undodir=~/.vim/undo " save undo over restart
set undofile

autocmd Filetype json syntax match Comment +\/\/.\+$+ " highlight comments in json
set number " show line numbers
" it isn't 2020 anymore :(
"set pyx=2 " set python version?
set breakindent " pretty indent
set formatoptions+="lb" " linebreak between words
set lbr " break lines instead of scrolling
set nocompatible " denite wanted it
filetype plugin on " denite wanted it
syntax on " denite wanted it
set termguicolors " make colors prettier
set updatetime=100 " backup every 100 ms
set showbreak=\ \ \ \ \ \ \ \  " indent wrapped lines
set mouse=a " enable using mouse (and scroll wheel)
set gdefault " find and replace globally by default 
set virtualedit=block " allow visual block selection out of buffer

set shiftwidth=4 " make indentation less pronounced
set expandtab
set tabstop=4

set scrolloff=2 " margin on bottom
set autoread " read files changed in other editors

let first_run = 0
if has('win32') " Installs Vim-Plug TODO: fix this, it currently works on 0% of platforms
	if empty(glob($HOME . '\AppData\Local\nvim\autoload'))
		exec 'silent !curl -fLo ' . $HOME . '\AppData\Local\nvim\autoload\plug.vim --create-dirs '
					\ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
else
	let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
	if !filereadable(autoload_plug_path)
		silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
			\ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
		execute 'source ' . fnameescape(autoload_plug_path)
		let first_run = 1
	endif
	unlet autoload_plug_path
endif

call plug#begin('~/.vim/plugged') " plugins
Plug 'dracula/vim', {'as': 'dracula'} " blue colorscheme
Plug 'junegunn/goyo.vim' " focus
Plug 'preservim/nerdtree' " fancy ls
Plug 'airblade/vim-gitgutter' " auto git diff
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocomplete
Plug 'Shougo/denite.nvim', {'do' : ':UpdateRemotePlugins'} " file finding TODO: learn how to use or uninstall
Plug 'vimwiki/vimwiki' " hyperlinks in vim TODO: start using this or uninstall
Plug 'jackguo380/vim-lsp-cxx-highlight' " c, c++, c# highlighting
Plug 'tpope/vim-surround' " plugin for surrounding (html good) TODO: use this or uninstall
Plug 'tpope/vim-repeat' " plugin to make plugins work with .
Plug 'tpope/vim-fugitive' " git plugin
Plug 'tpope/vim-unimpaired' " url encoder, among others TODO: use this or uninstall
Plug 'sirtaj/vim-openscad' " openSCAD highlighting
Plug '907th/vim-auto-save' " autosave (activate with \as)
Plug 'gustavo-hms/garbo', {'as' : 'garbage'} " colorscheme for light backgrounds
Plug 'gcmt/taboo.vim' " set tab names
Plug 'Shirk/vim-gas' " asm highlighting
Plug 'NLKNguyen/papercolor-theme' " another theme
Plug '4513ECHO/vim-colors-hatsunemiku' " another theme
Plug 'fenetikm/falcon'
Plug 'jacoborus/tender.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'tomasiser/vim-code-dark'
Plug 'savq/melange'
Plug 'arcticicestudio/nord-vim'
Plug 'sickill/vim-monokai'
Plug 'AhmedAbdulrahman/aylin.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'fcpg/vim-farout'
"Plug 'pgdouyoun/vim-yin-yang'
"Plug 'FranzyExists/aquarium-vim'
Plug 'DingDean/wgsl.vim', {'branch': 'main'}
Plug 'foxbunny/vim-amber'
Plug 'SirVer/ultisnips'
Plug 'tribela/vim-transparent'
Plug 'mbbill/undotree'
" Plug 'danth/pathfinder.vim' " training
Plug 'yuttie/comfortable-motion.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }
" Plug 'andweeb/presence.nvim' " discord
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'jdhao/better-escape.vim'
Plug 'tikhomirov/vim-glsl'
call plug#end()

lua require("toggleterm").setup()
lua require('crates').setup()
" default
let g:transparent_groups = ['Normal', 'Comment', 'Constant', 'Special', 'Identifier',
                            \ 'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
                            \ 'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
                            \ 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer']

" coc.nvim
let g:transparent_groups += ['NormalFloat', 'CocFloating']

if first_run
	PlugInstall --sync " install plugins
	CocInstall coc-json coc-css coc-html coc-eslint coc-tsserver coc-pyright coc-stylelint coc-tslint coc-vimlsp coc-java coc-word coc-dictionary coc-spell-checker coc-toml coc-rust-analyzer coc-lua " install autocomplete plugins
	silent execute "!mkdir -p " . g:session_dir
	silent execute "!mkdir -p " . &l:backupdir
	silent execute "!mkdir -p " . &l:directory
	silent execute "!mkdir -p " . &l:undodir
endif
unlet first_run

color falcon " colorscheme

autocmd FileType denite call s:denite_my_settings() " denite config TODO figure out how to use this
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

if empty(argv()) " custom nvim home screen
    set buftype=nofile " disable undo warnings
    file startup " set name

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

function! Opensession() " open session under cursor, or run homepage command
	if getline(".") == "Close" " clear buffer, for example to write something
		silent normal uu
		silent nun <Enter>
		" unmap enter (disable this function from running again)
        bd
		echo ""
	elseif getline(".") == "    Exit" " quit nvim
		silent normal uu
		exit
	elseif getline(".") == "    Wiki" " open vimwiki
		silent normal uu\ww
	elseif getline(".") ==  "    NTree" " open nerdtree
        silent normal uu
        bd
        " the thing on the following line not existing probably cost me several
        " hours over the years cleaning up random empty files with one-word
        " names
		silent nun <Enter>
        NERDTreeToggle
	elseif getline(".") == ""
		echo ""
	elseif getline(".") == "Menu"
		normal oExit
		normal oNTree
		normal oWiki
		normal oEv3
		normal o
		normal V4k>
		normal 2GA (Open)
		normal 0
	elseif getline(".") == "Menu (Open)"
		" normal jV3jdk
		silent normal u
        echo ""
	else
		let g:selected_line = getline(".") " get line under cursor
		silent normal uu
		" clear buffer

		exec 'silent !touch ' . g:session_dir. '/' . g:selected_line
		exec 'so ' . g:session_dir. '/' . g:selected_line
		" open session under cursor
		nun <Enter>
		" unmap enter (disable this function from running again)
	endif
endfunction
