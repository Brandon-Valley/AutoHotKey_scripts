; #Requires AutoHotkey v2.0

; MyGui := Gui()
; MyGui.Add("Edit", "w600")  ; Add a fairly wide edit control at the top of the window.
; MyGui.Add("Text", "Section", "First Name:")  ; Save this control's position and start a new section.
; MyGui.Add("Text",, "Last Name:")
; MyGui.Add("Edit", "ys")  ; Start a new column within this section.
; MyGui.Add("Edit")
; MyGui.Add("Edit", "ys")
; MyGui.Show




; ; Create a new Gui named App
; App := Gui("Resize")
; App.Title := "My App"

; ; Add an Edit control and a Text control
; Edit := App.AddEdit("ReadOnly vEdit")
; Text := App.AddText("vText")

; ; Set the OnEvent for the Edit control to copy its content to the clipboard when it's clicked
; Edit.OnEvent("LeftClick", Func("CopyToClipboard"))

; ; Show the Gui
; App.Show()

; ; This function copies the content of the Edit control to the clipboard
; ; and updates the Text control to show "Copied"
; CopyToClipboard(ctrl) {
;     ; Copy the content of the Edit control to the clipboard
;     Clipboard := ctrl.Value

;     ; Update the Text control to show "Copied"
;     Text.Value := "Copied"

;     ; Set a timer to clear the "Copied" message when the clipboard is updated
;     SetTimer(Func("ClearCopiedMessage"), -50)
; }

; ; This function clears the "Copied" message when the clipboard is updated
; ClearCopiedMessage() {
;     ; If the clipboard content is not the same as the Edit control content,
;     ; clear the "Copied" message
;     if (Clipboard != Edit.Value) {
;         Text.Value := ""
;     }
; }
#Requires AutoHotkey v2.0

MyGui:= Gui()    
myGui.Title := "Test" ;Gui Name    
MyBtn_Click(*) ;Function to be called when button pressed
{
    msgBox("Pressed Button")    
}    
; myBtn := MyGui.AddButton(,"OOK") ;Adds an ok Button to the Gui
myBtn := MyGui.AddEdit(,"OOK") ;Adds an ok Button to the Gui
myBtn.OnEvent("Change", MyBtn_Click) ;Call the function
myGui.Show() ;Shows Gui