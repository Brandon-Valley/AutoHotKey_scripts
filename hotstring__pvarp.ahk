#Requires Autohotkey v1.1
#SingleInstance, force


::pvarp::
cb_no_double_quotes := StrReplace(Clipboard, """", "'")
SendInput, print("
SendInput %cb_no_double_quotes%
SendInput, :")

SendInput, {enter}
sleep 100

SendInput, pprint(
SendInput, %cb_no_double_quotes%
SendInput, )
