#Requires AutoHotkey v2.0

; App.AddButton("Default w80", "Load File").OnEvent("Click", LoadFile)






SetTextAndResize(controlHwnd, newText, fontOptions := "", fontName := "") {
    Gui 9:Font, fontOptions, fontName
    Gui 9:Add, "Text", "R1", newText
    T := GuiControlGet("Pos", 9, "Static1")
    Gui 9:Destroy
    
    GuiControl("", controlHwnd, newText)
    GuiControl("Move", controlHwnd, "h" . T.H . " w" . T.W)
}








UpdateOutput(ctrl, unused) {
    cOutputEdit.value := StrUpper(ctrl.value)
}







LoadFile(ctrl, unused) {
    ; File selection is real easy in AHK!
    ; READ MORE: https://www.autohotkey.com/docs/v2/lib/FileSelect.htm
    file := FileSelect("1")
    if file {
        cClipboardEdit.value := FileRead(file)
        UpdateOutput(cClipboardEdit, "unused")
    }
}





; cClipboardEdit.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()


; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.

NumpadRight::MsgBox("This will be unbound when ExitApp(0) is called")