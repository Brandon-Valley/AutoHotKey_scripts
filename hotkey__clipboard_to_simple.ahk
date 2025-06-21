; AutoHotkey v2.0+
#Requires AutoHotkey v2.0
#SingleInstance Force

^+!q::  ; ^ = Ctrl, + = Shift, ! = Alt, q = Q
{
    ; 1. Grab current clipboard (any format) as plain text
    text := A_Clipboard  ; AutoHotkey converts it to plain text automatically

    ; 2. Normalize line endings and strip leading/trailing whitespace/newlines
    text := StrReplace(text, "`r`n", "`n")   ; CRLF - LF (optional, keeps things tidy)
    text := Trim(text)                       ; removes spaces, tabs, newlines at both ends

    ; 3. Push the cleaned text back onto the clipboard
    A_Clipboard := text
    ClipWait(0.2)

    ; That's it!  Windows Clipboard History (Win+V) now shows the new item,
    ; while your original rich-text/HTML copy remains one slot down.
}
