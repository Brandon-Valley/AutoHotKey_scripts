#Requires AutoHotkey v2.0
#SingleInstance Force ; No others

^!z::  ; Press Ctrl+Alt+Z to activate the Tab key presses
{
    END_STR := "---"
    A_Clipboard := END_STR
    msgBox(END_STR . "BOOP", "BEEP" , "T0.05") ; Flash msgBox for visual feedback
}
