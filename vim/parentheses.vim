source ~/dotfiles/vim/func.vim

inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " <cmd>call QuotesHelper("\"")<CR>
inoremap ' <cmd>call QuotesHelper("'")<CR>
inoremap <BS> <cmd>call MDel("<BS>")<CR>
inoremap <C-w> <cmd>call MDel("<C-w>")<CR>

function QuotesHelper(c)
    let charAtRight = CharAtRight()
    if charAtRight == '' || charAtRight == ' '
        call feedkeys(a:c . a:c . "\<Left>", "nt")
        return
    endif

    call feedkeys(a:c, "nt")
endfunction

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
