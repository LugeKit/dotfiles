function! CharAfterCursor()
	return strcharpart(getline('.'), strchars(strpart(getline('.'), 0, col('.')-1)) + 1, 1)
endfunction

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

let g:window_mode_is_on = 0
function! ToggleWindowMode()
	if g:window_mode_is_on
		let g:window_mode_is_on = 0
		nunmap <
		nunmap >
		nunmap -
		nunmap +
	else
		let g:window_mode_is_on = 1
		nnoremap < <C-w><
		nnoremap > <C-w>>
		nnoremap - <C-w>-
		nnoremap + <C-w>+
	endif
	echo "window mode is toggled to: " . g:window_mode_is_on
endfunction
