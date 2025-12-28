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
  $pattern = [regex]::Escape($env:userprofile)
  $prompt_string = "$(Get-Location)" -replace $pattern, "~"

  $git_info = ""
  # 检查是否在 git 仓库
  git rev-parse --is-inside-work-tree 2>$null | Out-Null
  if ($?) {
    # 1. 分支名
    $branch = git branch --show-current --no-color

    # 2. 统计待提交的文件数 (Modified/Untracked/Deleted)
    $modifications = (git status --porcelain 2>$null | Measure-Object).Count
    $mod_str = if ($modifications -gt 0) { " [+$modifications]" } else { "" }

    # 3. 统计待推送 (Ahead) 和 待拉取 (Behind)
    # @{u} 代表当前分支追踪的远程分支
    $ahead_behind = git rev-list --left-right --count "HEAD...@{u}" 2>$null
    $push_pull_str = ""
    if ($?) {
      if ($ahead_behind -match "(\d+)\s+(\d+)") {
        $ahead = $Matches[1]
        $behind = $Matches[2]
        if ($ahead -gt 0) { $push_pull_str += " ↑$ahead" }  # 待推送
        if ($behind -gt 0) { $push_pull_str += " ↓$behind" } # 待拉取
      }
    }
    else {
      # 如果没有关联远程分支，显示一个图标提醒
      $push_pull_str = " !untracked"
    }

    # 颜色配置: 分支(青色), 待提交(黄色), 待推送(紫色)
    $git_info = " (`e[36m$branch`e[0m`e[33m$mod_str`e[0m`e[35m$push_pull_str`e[0m)"
  }

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
    [Parameter(Mandatory, HelpMessage = "Please provide a valid command")]
    $command
  )
  Get-Command -Name $command | Select-Object -ExpandProperty Source
}

function cdproject {
  Set-Location D:/projects/
}
