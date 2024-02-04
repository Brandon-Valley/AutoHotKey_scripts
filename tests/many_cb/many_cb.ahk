
; https://www.hillelwayne.com/post/ahk-scripts-project/

#Requires AutoHotkey v2.0
#SingleInstance Force ; No others

#Include ClipboardHistory.ahk
#Include StrUtils.ahk

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

C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS := ""
C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN := "Section ys" ; Start a new column within this section. - NOT ACTUALLY SURE WHAT SECTION DOES

cb := A_Clipboard


App := Gui("Resize", "Clipboard Tools")
App.SetFont("s12")

defaultClipboardToolNewEditOptions := " ReadOnly r8 w300 -Wrap "


AddToolControls(
    toolOutputStr   := cb,
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewTextText    := "Plain Text:",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := StrUpper(cb),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewTextText    := "Uppercase:",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := StrLower(cb),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewTextText    := "Lowercase:",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := Trim(cb),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewTextText    := "Trim:",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := MultiStrRemove(cb, ["`"", "'"]),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewTextText    := "Remove Quotes",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := StrReplace(cb, ",", ""),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewTextText    := "Remove Commas",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

AddToolControls(
    toolOutputStr   := GetCombinedClipboardHistoryItemText(),
    guiObject       := App,
    cNewTextOptions := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewTextText    := "ClipboardHistoryItem:",
    cNewEditOptions := defaultClipboardToolNewEditOptions
)

; cClipboardEdit.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()

; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.
3::MsgBox("This will be unbound when ExitApp(0) is called")



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
