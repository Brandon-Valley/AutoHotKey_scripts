#SingleInstance, force

; https://www.reddit.com/r/AutoHotkey/comments/p4byvc/is_there_a_way_to_copy_the_current_timestamp_of_a/
; "C:\Program Files (x86)\MPC-HC\mpc-hc.exe"

F3:: ; change this hotkey according to your needs
; OldClip:=Clipboard ; Store current clipboard data in another value
Send, ^g ; Shows Go to time window
Send, ^a
Send, ^c

ClipWait, 2 ; Only need to wait 1 sec for it to work but wait 2 so you can see the box pop up for a sec for visual feedback
Send, {Esc}
