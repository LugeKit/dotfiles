" Vim settings {{{
mapclear
set hlsearch
set incsearch
set nu
set rnu
set ignorecase
set smartcase
set clipboard=unnamed
set updatetime=250

" timeoutlen: delay for vim mappings finished.
" ttimeoutlen: delay for keycodes from terminal to vim. i.e, some terminal
" will map <Esc> as shortcut, so when pressing <Esc>, vim will wait
" ttimeoutlen to get the <Esc>, and it will result a lag from exiting insert
" mode.
set timeoutlen=1000
set ttimeoutlen=5

set scrolloff=10
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=0
set smarttab
set shortmess-=S
filetype on
filetype plugin on
filetype indent on
syntax enable
let mapleader = " "

" blinking bar in insert mode
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
" }}}

source ~/dotfiles/vim/windows.vim
source ~/dotfiles/vim/func.vim
source ~/dotfiles/vim/parentheses.vim


" Key mappings {{{
" Normal mappings
noremap <C-h> ^
noremap <C-l> $
noremap <C-j> 5j
noremap <C-k> 5k
nnoremap ; :
nnoremap : ;
nnoremap <silent> <leader>ta :tabo<CR>
nnoremap <silent> <leader>// :rightbelow vsplit $MYVIMRC<CR>
inoremap <C-D> <Esc>
inoremap <C-x> <Delete>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-j> <S-Left>
cnoremap <C-k> <S-Right>
xnoremap y y`>
xnoremap ; :
xnoremap : ;

" ESC to switch off highlights
nnoremap <silent> <ESC> :noh<CR>

" Substitute enhancement
nnoremap <leader>s :%s/\v
xnoremap <leader>s :s/\v

nnoremap <F1> :below terminal<CR>
" }}}

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
	autocmd BufWritePost *vimrc :source <afile>
	autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

source ~/dotfiles/vim/ide.vim
