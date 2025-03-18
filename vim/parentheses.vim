inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " <cmd>call QuotesHelper("\"")<CR>
inoremap ' <cmd>call QuotesHelper("'")<CR>
inoremap ) <cmd>call MoveRightOrInsert(")")<CR>
inoremap ] <cmd>call MoveRightOrInsert("]")<CR>
inoremap } <cmd>call MoveRightOrInsert("}")<CR>
inoremap > <cmd>call MoveRightOrInsert(">")<CR>

function CharAtRight()
    let line = getline('.')
    let idx = col('.') - 1
    let char = idx < len(line) ? line[idx] : ''
    return char
endfunction

function CharAtLeft()
    let line = getline('.')
    let idx = col('.')
    return idx > 1 && idx < len(line)-1 ? line[idx] : ''
endfunction

function QuotesHelper(c)
    let charAtRight = CharAtRight()
    if a:c == charAtRight
        call feedkeys("\<Right>", "nt")
        return
    endif
    call feedkeys(a:c . a:c . "\<Left>", "nt")
endfunction

function MoveRightOrInsert(c)
    let charAtRight = CharAtRight()
    if a:c == charAtRight
        call feedkeys("\<Right>", "nt")
        return
    endif
    call feedkeys(a:c, "nt")
endfunction

function Backspace()
    let charAtRight = CharAtRight()
    let charAtLeft = CharAtLeft()
    if charAtRight == charAtLeft
        call feedkeys("\<BS>\<Delete>", "nt")
    else
        call feedkeys("\<BS>", "nt")
    endif
endfunction
