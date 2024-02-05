
; https://www.hillelwayne.com/post/ahk-scripts-project/

; TODO
; - alighn



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


defaultClipboardToolNewEditOptions := " ReadOnly r4 w400 -Wrap "

; ==================================================
; Set title & placement of each VisualClipboardTool
; ==================================================

; Special
ShowOriginalClipboardTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Original Clipboard:",
)
ShowClipboardHistoryItemTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "ClipboardHistoryItem:",
)
; Align
AlignTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Align:",
)

; Format
ShowCurrentPlainTextTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
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

; Remove
TrimTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Trim:",
)
RemoveDoubleQuotesTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Remove Double Quotes:",
)
RemoveCommasTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Remove Commas:",
)

; Add
AddDoubleQuotesTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__START_NEW_COLUMN,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Add Double Quotes:",
)
AddSingleQuotesTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Add Single Quotes:",
)
AddCommasTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Add Commas",
)
AddDictRightTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Add Dict - Right",
)
AddDictLeftTool := VisualClipboardTool(
    guiObject              := App,
    cNewTextOptions        := C_NEW_TEXT_OPTIONTS__INSERT_UNDER_PREVIOUS,
    cNewEditOptions        := defaultClipboardToolNewEditOptions,
    cNewTextText           := "Add Dict - Left",
)





; =====================================================================
; Define how each tool will be updated during runtime loop
; =====================================================================
UpdateVisualClipboardTools(unusedParamNeededForOnClipboardChange?) {
    cb := A_Clipboard

    ShowCurrentPlainTextTool.Update(cb)

    ShowUppercaseTool.Update(StrUpper(cb))

    ShowLowercaseTool.Update(StrLower(cb))

    TrimTool.Update( GetStrAfterAppliedFuncToEachLine( cb, Trim ) )
        
    RemoveDoubleQuotesTool.Update(MultiStrRemove(cb, ["`"", "'"]))

    RemoveCommasTool.Update(StrReplace(cb, ",", ""))

    ShowClipboardHistoryItemTool.Update(GetCombinedClipboardHistoryItemText())

    AddDoubleQuotesTool.Update(GetStrAfterWrapEachLineWithStr(cb, "`""))
    AddSingleQuotesTool.Update(GetStrAfterWrapEachLineWithStr(cb, "'"))

    AddCommasTool.Update(GetStrAfterAddStrtoEndOfEachLine(cb, ","))

    AddDictRightTool.Update(GetStrAddedToDict(cb, "right"))
    AddDictLeftTool.Update(GetStrAddedToDict(cb, "left"))

    AlignTool.Update(AlignStr(cb, ":"))

}


; ====================================================
; Set value for tools that dont change during runtime
; ====================================================
ShowOriginalClipboardTool.Update(A_Clipboard)

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

GetCombinedClipboardHistoryItemText(endStr := "---", cbItemSeperator := "`n", returnIfEndNotFound := "") {
    resultStr := ""
    cbItemText := ""
    i := 1
    while(i < MAX_WINDOWS_CLIPBOARD_HISTORY_ITEMS){
        cbItemText := ClipboardHistory.GetHistoryItemText(i)
        if (cbItemText == endStr){
            return resultStr
        }
        resultStr := resultStr . cbItemSeperator . cbItemText
        i := i + 1
    }
    return returnIfEndNotFound
}

; TODO play with other params
GetStrAddedToDict(mainStr, sideToInsertMainStr := "right", otherSideStr := "`"`"", indentStr := "", wrapCurlyBraces := 0) {
    workStr := mainStr
    if (sideToInsertMainStr == "right") {
        workStr := GetStrAfterAddStrToEndOfEachLine(workStr, " : " . otherSideStr . ",") 
    }
    else if (sideToInsertMainStr == "left") {
        _Func(line) {
            return otherSideStr . " : " . workStr . ","
        }
        workStr := GetStrAfterAppliedFuncToEachLine(workStr, _Func)
    }
    else 
        throw Error("Invalid sideToInsertMainStr:" . sideToInsertMainStr, -1)

    return workStr
}