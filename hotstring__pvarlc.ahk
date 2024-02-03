#SingleInstance, force
::pvarlc::
cb_no_double_quotes1 := StrReplace(Clipboard, """", "'")
cb_no_double_quotes := StrReplace(cb_no_double_quotes1, "+", "{+}")
SendInput, print( "
SendInput %cb_no_double_quotes%
SendInput, : {{}{}}".format(
SendInput %cb_no_double_quotes%
SendInput, ) )

