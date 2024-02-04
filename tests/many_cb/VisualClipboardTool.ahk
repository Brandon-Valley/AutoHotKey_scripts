#Requires AutoHotkey v2.0

DEFAULT_EDIT_FONT_NAME := "Consolas"
class VisualClipboardTool
{
; ; properties
;     static HistoryEnabled {
;         get => CBH_API.HistoryEnabled
;         set => CBH_API.HistoryEnabled := value ; boolean
;     }
;     static Count => CBH_API.GetClipboardHistoryItems()

; ; methods
;     static ClearHistory()                     => CBH_API.ClearHistory()
;     static DeleteHistoryItem(index)           => CBH_API.DeleteHistoryItem(index) ; 1 based index
;     static GetHistoryItemText(index)          => CBH_API.GetHistoryItemText(index)
;     static PutHistoryItemIntoClipboard(index) => CBH_API.PutHistoryItemIntoClipboard(index)
;     static GetAvailableFormats(index)         => CBH_API.GetAvailableFormats(index)


    ; Edit Control value is updated with return of toolFunc on each clipboard change
    ; __new(guiObject, cNewTextOptions, cNewTextText, cNewEditOptions, toolFunc, optionalToolFuncParams := unset) {
    __new(guiObject, cNewTextOptions, cNewEditOptions, cNewTextText, toolFunc) {
        ; this.toolFunc = toolFunc


        cNewText := guiObject.AddText(cNewTextOptions, cNewTextText)
        cNewEdit := guiObject.AddEdit(cNewEditOptions)
        cNewEdit.SetFont(, DEFAULT_EDIT_FONT_NAME)
        
        UpdateEditControlValue(unusedParamNeededForOnClipboardChange) {
            ; cNewEdit.value := toolFunc(optionalToolFuncParams)
            cNewEdit.value := toolFunc()
        }
        OnClipboardChange UpdateEditControlValue
    }
}
