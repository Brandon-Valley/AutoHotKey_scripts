#Requires AutoHotkey v2.0
#SingleInstance Force ; No others


^!x::  ; Press Ctrl+Alt+X to activate the Tab key presses
{
    Run "autohotkey.exe " . A_WorkingDir . "\many_cb.ahk"
}
