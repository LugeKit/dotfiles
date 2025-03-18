" example: nnoremap cin" f"vi"c
function! OperatorForNextTargetInIDE(actions, targets)
for action in a:actions
		for target in a:targets
			let map_key = action . "in" . target
			let map_action = "f" . target . "vi" . target . action
			execute 'nnoremap ' . l:map_key . ' ' . l:map_action
		endfor
	endfor
endfunction

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

