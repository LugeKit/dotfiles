source ~/dotfiles/vim/func.vim

" surround selected area
xnoremap s( mp<ESC>`>a)<ESC>`<i(<ESC>`pl
xnoremap s" mp<ESC>`>a"<ESC>`<i"<ESC>`pl
xnoremap s' mp<ESC>`>a'<ESC>`<i'<ESC>`pl
xnoremap s[ mp<ESC>`>a]<ESC>`<i[<ESC>`pl
xnoremap s< mp<ESC>`>a><ESC>`<i<<ESC>`pl
xnoremap s{ mp<ESC>`>a}<ESC>`<i{<ESC>`pl

" surround current *word*
nnoremap s( mpviw<ESC>`>a)<ESC>`<i(<ESC>`pl
nnoremap s" mpviw<ESC>`>a"<ESC>`<i"<ESC>`pl
nnoremap s' mpviw<ESC>`>a'<ESC>`<i'<ESC>`pl
nnoremap s[ mpviw<ESC>`>a]<ESC>`<i[<ESC>`pl
nnoremap s< mpviw<ESC>`>a><ESC>`<i<<ESC>`pl
nnoremap s{ mpviw<ESC>`>a}<ESC>`<i{<ESC>`pl

" remove current word's surrounding
nnoremap S( mpva(<ESC>`>"_x`<"_x`ph
nnoremap S" mpva"<ESC>`>"_x`<"_x`ph
nnoremap S' mpva'<ESC>`>"_x`<"_x`ph
nnoremap S[ mpva[<ESC>`>"_x`<"_x`ph
nnoremap S< mpva<<ESC>`>"_x`<"_x`ph
nnoremap S{ mpva{<ESC>`>"_x`<"_x`ph

" jumping to next area
onoremap in( :<C-U>normal! f(vi(<CR>
onoremap in< :<C-U>normal! f<vi<<CR>
onoremap in[ :<C-U>normal! f[vi[<CR>
onoremap in" :<C-U>normal! f"vi"<CR>
onoremap in' :<C-U>normal! f'vi'<CR>
onoremap in{ :<C-U>normal! f{vi{<CR>

if !exists("&ide")
    inoremap { {}<Left>
    inoremap ( ()<Left>
    inoremap [ []<Left>
    inoremap " <cmd>call feedkeys("\"\"\<Left>", "nt")<CR>
    inoremap ' <cmd>call feedkeys("''\<Left>", "nt")<CR>
    inoremap <BS> <cmd>call MDel("<BS>")<CR>
    inoremap <C-w> <cmd>call MDel("<C-w>")<CR>
    inoremap <CR> <cmd>call EnterHelper()<CR>
endif

" use <C-Z> to act as a normal <BS>
inoremap <C-Z> <BS>

function MDel(c)
    let charAtRight = CharAtRight()
    let charAtLeft = CharAtLeft()
    if (charAtLeft == '(' && charAtRight == ')') ||
                \ (charAtLeft == "'" && charAtRight == "'") ||
                \ (charAtLeft == '"' && charAtRight == '"') ||
                \ (charAtLeft == "[" && charAtRight == "]") ||
                \ (charAtLeft == "{" && charAtRight == "}") ||
                \ (charAtLeft == "<" && charAtRight == ">")
        call feedkeys("\<Delete>", "nt")
    endif
    call feedkeys(a:c, "nt")
endfunction

function EnterHelper()
    let charAtLeft = CharAtLeft()
    let charAtRight = CharAtRight()
    if charAtLeft == '{' && charAtRight == '}'
        call feedkeys("\<CR>\<ESC>O", "nt")
        return
    endif
    call feedkeys("\<CR>", "nt")
endfunction
