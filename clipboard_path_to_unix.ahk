#Requires Autohotkey v1.1
#SingleInstance, force

$^q::
Clipboard := StrReplace(Clipboard, "`\", "/")