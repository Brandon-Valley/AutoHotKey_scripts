#SingleInstance, force
::pvarl::
cb_no_double_quotes := StrReplace(Clipboard, """", "'")
SendInput, print(f"{{}len(
SendInput %cb_no_double_quotes%
SendInput, )={}}")
