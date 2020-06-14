
let g:session_dir = 'C:\Users\infiniti\Desktop\workspace\programmimg\Vim\nvim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><Left><Left><Left><Left><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sd :!del ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>gc :!git add . <enter>:!git commit -m "" & git push<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>'
exec 'nnoremap <Leader>gp :!git push<enter>'
exec 'nnoremap <Leader>gpu :!git pull<enter>'
exec 'nnoremap <Leader>gd :!git diff<enter>'
exec 'nnoremap <C-h> <C-w>h'
exec 'nnoremap <C-j> <C-w>j'
exec 'nnoremap <C-k> <C-w>k'
exec 'nnoremap <C-l> <C-w>l'
exec 'nnoremap <C-Left> <C-w><'
exec 'nnoremap <C-Down> <C-w>-'
exec 'nnoremap <C-Up> <C-w>+'
exec 'nnoremap <C-Right> <C-w>>'
exec 'nnoremap <Leader>n :NERDTreeToggle<enter>'
exec 'nnoremap <Leader>g :Goyo<enter>'
exec 'nnoremap <Leader> b :w<Enter>:!pandoc %:t --pdf-engine=xelatex -o %:t:r.html<Enter><Enter>'
set nobackup nowritebackup
:tnoremap <Esc> <C-\><C-n>
autocmd FileType json syntax match Comment +\/\/.\+$+
set number
set pyx=2
set breakindent
set formatoptions+="lb"
set lbr
set nocompatible
filetype plugin on
syntax on
if empty(glob('C:\Users\infiniti\AppData\Local\nvim\autoload'))
  silent !curl -fLo C:\Users\infiniti\AppData\Local\nvim\autoload --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()
color dracula
set termguicolors
set updatetime=100

" Define mappings
autocmd FileType denite call s:denite_my_settings()
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
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
