# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

[cultureinfo]::CurrentUICulture = 'en-US'

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-Alias -Name kg -Value kgrep
Set-Location D:

function Prompt {
    $pattern = $env:userprofile -replace '\\', '\\'
    $prompt_string = "$(Get-Location)" -replace $pattern, "~"

    $git_info = ""
    # 检查是否在 git 仓库中
    git rev-parse --is-inside-work-tree 2>$null | Out-Null
    if ($?) {
        # 1. 获取当前分支名
        $branch = git branch --show-current --no-color

        # 2. 获取改动统计 (待提交的文件数量)
        # --short 给出的格式如 " M file.txt", 统计行数即为改动文件数
        $modifications = (git status --porcelain 2>$null | Measure-Object).Count
        $mod_str = if ($modifications -gt 0) { " [+$modifications]" } else { "" }

        # 3. 获取与远程仓库的差异 (Unpushed/Unpulled)
        # 格式为 "领先数    落后数"
        $status_count = git rev-list --left-right --count HEAD...@{u} 2>$null
        $push_pull_str = ""
        if ($status_count -and $status_count -match "(\d+)\s+(\d+)") {
            $ahead = $Matches[1]
            $behind = $Matches[2]
            if ($ahead -gt 0) { $push_pull_str += " ↑$ahead" }
            if ($behind -gt 0) { $push_pull_str += " ↓$behind" }
        }

        # 组合 Git 信息：(分支名 [+改动数] ↑领先数)
        $git_info = " (`e[36m$branch`e[0m`e[33m$mod_str`e[0m`e[35m$push_pull_str`e[0m)"
    }

    # 输出最终的 Prompt
    "`e[1m$prompt_string`e[0m$git_info "
}

function proxy_on {
  $env:HTTP_PROXY = "127.0.0.1:8889"
  $env:HTTPS_PROXY = "127.0.0.1:8889"
}

function proxy_off {
  $env:HTTP_PROXY = ""
  $env:HTTPS_PROXY = ""
}

function which {
  param (
    [Parameter(Mandatory, HelpMessage="Please provide a valid command")]
    $command
  )
  Get-Command -Name $command | Select-Object -ExpandProperty Source
}

function cdproject {
  Set-Location D:/projects/
}
