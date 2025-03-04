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
set timeoutlen=1000
set ttimeoutlen=100
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
" }}}

" Windows settings {{{
if !empty(glob("C:/Program Files/PowerShell/7/pwsh.exe"))
	:language en
	set shell =\"C:/Program\ Files/PowerShell/7/pwsh.exe\"
    inoremap <C-Backspace> <C-w>
endif
" }}}

source ~/dotfiles/vim/func.vim

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
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>
xnoremap y y`>
xnoremap ; :
xnoremap : ;

" ESC to switch off highlights
nnoremap <silent> <ESC> :noh<CR>

" Substitute enhancement
nnoremap <leader>s :%s/
xnoremap <leader>s :s/

nnoremap <F1> :below terminal<CR>
nnoremap <leader>W :call ToggleWindowMode()<CR>
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

" Parenthsis settings {{{
" s to surround things
" S to unsurround things
if exists("&ide")
    xnoremap s( c()<ESC>hp
    xnoremap s" c""<ESC>hp
    xnoremap s' c''<ESC>hp
    xnoremap s[ c[]<ESC>hp
    xnoremap s< c<><ESC>hp
    xnoremap s{ c{}<ESC>hp
else
    xnoremap s( <ESC>`>a)<ESC>`<i(<ESC>
    xnoremap s" <ESC>`>a"<ESC>`<i"<ESC>
    xnoremap s' <ESC>`>a'<ESC>`<i'<ESC>
    xnoremap s[ <ESC>`>a]<ESC>`<i[<ESC>
    xnoremap s< <ESC>`>a><ESC>`<i<<ESC>
    xnoremap s{ <ESC>`>a}<ESC>`<i{<ESC>
endif

nnoremap s( mpciw()<ESC>P`pl
nnoremap s" mpciw""<ESC>P`pl
nnoremap s' mpciw''<ESC>P`pl
nnoremap s[ mpciw[]<ESC>P`pl
nnoremap s< mpciw<><ESC>P`pl
nnoremap s{ mpciw{}<ESC>P`pl

nnoremap S( mpva(<ESC>`>x`<x`ph
nnoremap S" mpva"<ESC>`>x`<x`ph
nnoremap S' mpva'<ESC>`>x`<x`ph
nnoremap S[ mpva[<ESC>`>x`<x`ph
nnoremap S< mpva<<ESC>`>x`<x`ph
nnoremap S{ mpva{<ESC>`>x`<x`ph

onoremap in( :<C-U>normal! f(vi(<CR>
onoremap in< :<C-U>normal! f<vi<<CR>
onoremap in[ :<C-U>normal! f[vi[<CR>
onoremap in" :<C-U>normal! f"vi"<CR>
onoremap in' :<C-U>normal! f'vi'<CR>
onoremap in{ :<C-U>normal! f{vi{<CR>

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

