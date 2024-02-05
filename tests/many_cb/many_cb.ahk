﻿
; https://www.hillelwayne.com/post/ahk-scripts-project/

#Requires AutoHotkey v2.0
#SingleInstance Force ; No others

#Include ClipboardHistory.ahk
#Include StrUtils.ahk
#Include VisualClipboardTool.ahk

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

; ==================================================
; Set title & placement of each VisualClipboardTool
; ==================================================
ShowCurrentPlainTextTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Current as Plain-Text:",
)
ShowUppercaseTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Uppercase:",
)
ShowLowercaseTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Lowercase:",
)
TrimTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Trim:",
)
RemoveQuotesTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Remove Quotes:",
)
RemoveCommasTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Remove Commas:",
)
ShowClipboardHistoryItemTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "ClipboardHistoryItem:",
)

; =====================================================================
; Define how each tool will be updated during runtime loop
; =====================================================================
UpdateVisualClipboardTools(unusedParamNeededForOnClipboardChange?) {
    cb := A_Clipboard

    ShowCurrentPlainTextTool.Update(cb)

    ShowUppercaseTool.Update(StrUpper(cb))

    ShowLowercaseTool.Update(StrLower(cb))

    ; TrimTool.Update(Trim(cb))
    ; TrimTool.Update(GetEachLineTrimmed(cb))
    TrimTool.Update( GetStrAfterAppliedFuncToEachLine( cb, Trim ) )
        
    RemoveQuotesTool.Update(MultiStrRemove(cb, ["`"", "'"]))

    RemoveCommasTool.Update(StrReplace(cb, ",", ""))

    ShowClipboardHistoryItemTool.Update(GetCombinedClipboardHistoryItemText())
}

;==============================================================
; Configure how / when all tools will be updated (all at once)
;==============================================================

; Update tools for the first time
UpdateVisualClipboardTools()

; Update tools on each Clipboard update
OnClipboardChange UpdateVisualClipboardTools

;==================
; Other Gui Config
;==================

; cClipboardEdit.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()

; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.
3::MsgBox("This will be unbound when ExitApp(0) is called")

; ######################################################################################################################
; Methods
; ######################################################################################################################

_GetLinesFromStr(originalStr, delimiter := "`n") {
    return StrSplit(originalStr, delimiter)
}

; _Join(sep, params*) {
;     for index,param in params
;         str .= param . sep
;     return SubStr(str, 1, -StrLen(sep))
; }

; @param func - must take 1 argument for current line
GetStrAfterAppliedFuncToEachLine(originalStr, func) {
    sep := "`n"
    newStr := ""
    lines := _GetLinesFromStr(originalStr)
    for line in lines {
        newLine := func(line)
        newStr := newStr . newLine . sep
    }
    return SubStr(newStr, 1, -StrLen(sep))
}

GetEachLineTrimmed(originalStr) {

    
    sep := "`n"
    newStr := ""
    lines := _GetLinesFromStr(originalStr)
    for line in lines {
        newLine := Trim(line)
        ; newStr := newStr . new
        ; newStr := _Join("`n", newStr, newLine)
        newStr := newStr . newLine . sep
    }
    return SubStr(newStr, 1, -StrLen(sep))
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
