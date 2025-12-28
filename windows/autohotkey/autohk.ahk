; Use new instance to rewrite the old one
#SingleInstance Force

; # -> win
; ^ -> ctrl
; ! -> alt
; + -> shift
; & -> combination

; win+c -> copy
#c:: Send "^{Insert}"

; win+v -> paste
#v:: Send "+{Insert}"

; win+x -> cut
#x:: Send "+{Delete}"

; win+backspace -> delete to start of line
#Backspace:: Send "+{Home}{Backspace}"

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
#w:: WinMinimize("A")

; win+q -> quit current window
#q:: WinClose("A")

; win+a -> select all
#a:: Send "^a"
