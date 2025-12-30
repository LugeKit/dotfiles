; Use new instance to rewrite the old one
#SingleInstance Force
; Avoid recursive call
#UseHook true

ProcessSetPriority "High" ; 提高脚本优先级
SetWinDelay -1  ; 消除窗口操作导致的延迟

; # -> win
; ^ -> ctrl
; ! -> alt
; + -> shift
; & -> combination

; 用无意义的修饰键
A_MenuMaskKey := "vkE8"

; win+c -> copy
#c:: Send "^{Insert}"

; win+v -> paste
#v:: Send "+{Insert}"

; win+x -> cut
#x:: Send "+{Delete}"

; win+backspace -> delete to start of line
#Backspace::
{
    Send "+{Home}"
    ; some input can not handle it so quickly
    ; eg, Trae AI Input
    Sleep 20
    Send "{Backspace}"
}

; win+left -> Home
#Left:: Send "{Home}"

; win+right -> End
#Right:: Send "{End}"

; win+shift+left -> shift Home
#+Left:: Send "+{Home}"

; win+shift+right -> shift End
#+Right:: Send "+{End}"

; alt+z -> win+3
!z:: Send "#{3}"

; win+w -> hide current window
#w:: {
    if WinActive("ahk_exe Trae CN.exe") {
        ; win shift F12
        Send "{Blind}+{F12}"
        return
    }

    try {
        WinMinimize("A")
    }
}

; win+q -> quit current window
#q:: WinClose("A")

; win+a -> select all
#a:: Send "^a"

; win+u -> win shift F13
#u:: Send "{Blind}+{F13}"

; win+f -> win shift F11
#f:: Send "{Blind}+{F11}"

; 禁用原生的 CapsLock 逻辑
SetCapsLockState "AlwaysOff"

; --- 1. 单独按下 CapsLock：瞬间切换输入法 ---
English := 0x4090409
Chinese := 0x8040804
$*CapsLock::
{
    if GetKeyState("Shift", "P") OR GetKeyState("Ctrl", "P")
        return

    KeyWait "CapsLock"

    hwnd := WinExist("A")
    if !hwnd
        return

    currentHKL := DllCall("GetKeyboardLayout", "UInt", DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "Ptr", 0),
    "Ptr")
    if (currentHKL = English) {
        PostMessage(0x50, 0, Chinese, , "ahk_id " hwnd)
    } else {
        Send "^{Space}"
    }
}

; --- 2. 按下 Shift + CapsLock：切换大写状态 ---
+CapsLock::
{
    if GetKeyState("CapsLock", "T")
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "AlwaysOn"
}

; --- 3. 按下 Ctrl + CapsLock：切换英文输入法 ---
^CapsLock::
{
    hwnd := WinExist("A")
    if !hwnd
        return
    PostMessage(0x50, 0, English, , "ahk_id " hwnd)
}
