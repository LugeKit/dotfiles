source ~/dotfiles/vim/func.vim

inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " <cmd>call feedkeys("\"\"\<Left>", "nt")<CR>
inoremap ' <cmd>call feedkeys("''\<Left>", "nt")<CR>
inoremap <BS> <cmd>call MDel("<BS>")<CR>
inoremap <C-w> <cmd>call MDel("<C-w>")<CR>
inoremap <CR> <cmd>call EnterHelper()<CR>

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
