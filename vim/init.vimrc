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
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
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

" Register settings {{{
nnoremap x "_x
nnoremap c "_c
nnoremap C "_C
nnoremap <leader>d "_d
nnoremap <leader>D "_D
xnoremap x "_x
xnoremap c "_c
xnoremap C "_C
xnoremap <leader>d "_d
xnoremap <leader>D "_D
" }}}

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
	autocmd BufWritePost *vimrc :source <afile>
	autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

" Jetbrains IDE settings {{{
if exists("&ide")
	set highlightedyank
	set clipboard+=ideaput
    nmap <C-o> <Action>(Back)
    nmap <C-i> <Action>(Forward)
    nmap <C-w>H <Action>(MoveEditorToOppositeTabGroup)
    nmap <C-w>L <Action>(MoveEditorToOppositeTabGroup)
	nmap <leader>ff <Action>(SearchEverywhere)
	nmap <leader>fs <Action>(FindInPath)
	nmap <leader>fd <Action>(GotoDeclaration)
	nmap <leader>fr <Action>(ShowUsages)
	nmap <leader>fi <Action>(GotoImplementation)
	nmap <leader>fI <Action>(GotoSuperMethod)
	nmap <leader>fD <Action>(GotoTypeDeclaration)
	nmap <leader>gb <Action>(Annotate)
	nmap <leader>gu <Action>(Vcs.RollbackChangedLines)
	nmap <leader>gn <Action>(VcsShowNextChangeMarker)
	nmap <leader>gN <Action>(VcsShowPrevChangeMarker)
	nmap <leader>l <Action>(SelectInProjectView)
	nmap <leader>rn <Action>(RenameElement)
	nmap <leader>ca <Action>(ShowIntentionActions)
	nmap <leader>ta <Action>(CloseAllEditorsButActive)
    nmap [f <Action>(EditorCodeBlockStart)
    nmap ]f <Action>(EditorCodeBlockEnd)
	nmap <C-]> <Action>(NextTab)
	nmap <C-[> <Action>(PreviousTab)
	imap <C-i> <Action>(ParameterInfo)
	imap <C-w> <Action>(EditorDeleteToWordStart)

	command! GT action RunClass
    command! FM action ReformatCode
    command! FMF action ReformatFile
endif
" }}}

