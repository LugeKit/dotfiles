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
