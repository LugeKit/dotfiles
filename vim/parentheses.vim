inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " <cmd>call QuotesHelper("\"")<CR>
inoremap ' <cmd>call QuotesHelper("'")<CR>
inoremap <BS> <cmd>call MDel("<BS>")<CR>
inoremap <C-w> <cmd>call MDel("<C-w>")<CR>

function CharAtRight()
    let line = getline('.')
    let idx = col('.') - 1
    let char = idx < len(line) ? line[idx] : ''
    return char
endfunction

function CharAtLeft()
    let line = getline('.')
    let idx = col('.') - 2
    let char = idx >= 0 && idx < len(line) ? line[idx] : ''
    return char
endfunction

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
