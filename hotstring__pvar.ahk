#SingleInstance, force
::pvar::
cb_no_double_quotes := StrReplace(Clipboard, """", "'")
SendInput, print(f"{{}
SendInput %cb_no_double_quotes%
SendInput, ={}}")
