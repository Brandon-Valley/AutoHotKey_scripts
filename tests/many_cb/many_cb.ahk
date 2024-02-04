
; https://www.hillelwayne.com/post/ahk-scripts-project/

#Requires AutoHotkey v2.0
#SingleInstance Force ; No others

#Include ClipboardHistory.ahk

/* A simple demo of how easy it is to write a GUI in AHK. This will allcaps any string you copy into the input.
You can run this script on its own, or from your main script with

    Run "autohotkey.exe " . A_WorkingDir . "\Lib\GUIs\Upcaser.ahk"

Keeping GUIs separate is good unless they need to share information with the main script.

READ MORE:
    - https://www.autohotkey.com/docs/v2/lib/Gui.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiOnEvent.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiControls.htm
*/
MAX_WINDOWS_CLIPBOARD_HISTORY_ITEMS := 25

cb := A_Clipboard


App := Gui("Resize", "Clipboard Tools")
App.SetFont("s12")

og_clipboard_edit_opt_str := " r8 w300 -Wrap "


AddToolControls(
    toolOutputStr := cb,
    guiObject := App,
    cNewTextOptions := "", ; Add this set of Controls right under the previous
    cNewTextText := "Plain Text:",
    cNewEditOptions := "ReadOnly" . og_clipboard_edit_opt_str
)

AddToolControls(
    toolOutputStr := StrUpper(cb),
    guiObject := App,
    cNewTextOptions := "", ; Add this set of Controls right under the previous
    cNewTextText := "Uppercase:",
    cNewEditOptions := "ReadOnly" . og_clipboard_edit_opt_str
)

AddToolControls(
    toolOutputStr := StrLower(cb),
    guiObject := App,
    cNewTextOptions := "Section ys", ; Start a new column within this section. - NOT ACTUALLY SURE WHAT SECTION DOES
    cNewTextText := "Lowercase:",
    cNewEditOptions := "ReadOnly" . og_clipboard_edit_opt_str
)

AddToolControls(
    toolOutputStr := GetCombinedClipboardHistoryItemText(),
    guiObject := App,
    cNewTextOptions := "Section ys", ; Start a new column within this section. - NOT ACTUALLY SURE WHAT SECTION DOES
    cNewTextText := "ClipboardHistoryItem:",
    cNewEditOptions := "ReadOnly" . og_clipboard_edit_opt_str
)


/**
* Function: AddToolControls
* @param titleTextControlOptions Options:
*     V: Sets the control's Name.
*     Pos: xn yn wn hn rn Right Left Center Section VScroll HScroll
*     -Tabstop 
*     -Wrap 
*     BackgroundColor 
*     BackgroundTrans 
*     Border 
*     Theme 
*     Disabled 
*     Hidden
*/
AddToolControls(toolOutputStr, guiObject, cNewTextOptions, cNewTextText, cNewEditOptions, cNewEditFontName := "Consolas")  {
    cNewText := guiObject.AddText(cNewTextOptions, cNewTextText)
    cNewEdit := guiObject.AddEdit(cNewEditOptions)
    cNewEdit.SetFont(, cNewEditFontName)
    
    cNewEdit.value := toolOutputStr
}


GetCombinedClipboardHistoryItemText(endStr := "---", cbItemSeperator := "`n", returnIfEndNotFound := "") {
    resultStr := ""
    cbItemText := ""
    i := 1
    while(i <= MAX_WINDOWS_CLIPBOARD_HISTORY_ITEMS){
        cbItemText := ClipboardHistory.GetHistoryItemText(i)
        if (cbItemText == endStr){
            return resultStr
        }
        resultStr := resultStr . cbItemSeperator . cbItemText
        i := i + 1
    }
    return returnIfEndNotFound
}



; cClipboardEdit.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()


; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.
3::MsgBox("This will be unbound when ExitApp(0) is called")