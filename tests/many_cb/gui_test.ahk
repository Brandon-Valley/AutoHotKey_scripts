#Requires AutoHotkey v2.0

MyGui := Gui()
MyGui.Add("Edit", "w600")  ; Add a fairly wide edit control at the top of the window.
MyGui.Add("Text", "Section", "First Name:")  ; Save this control's position and start a new section.
MyGui.Add("Text",, "Last Name:")
MyGui.Add("Edit", "ys")  ; Start a new column within this section.
MyGui.Add("Edit")
MyGui.Add("Edit", "ys")
MyGui.Show
