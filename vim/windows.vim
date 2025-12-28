if !empty(glob("C:/Program Files/PowerShell/7/pwsh.exe"))
    " this is for vim->git bash
    " there will be an error for `language en` in git bash, windows
    silent! language en
	set shell =\"C:/Program\ Files/PowerShell/7/pwsh.exe\"
endif
