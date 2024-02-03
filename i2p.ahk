#Requires AutoHotkey v2.0

^!c::  ; Press Ctrl+Alt+C to activate the Tab key presses
Loop, 22 {
    Send {Tab}
    Sleep 50  ; Adjust the sleep time as needed to control the speed of key presses
}
return
