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


    /**
    * @param cTextOptions Options:
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
    __new(guiObject, cTextOptions, cEditOptions, cTextText) {
        this.cText := guiObject.AddText(cTextOptions, cTextText)
        this.cEdit := guiObject.AddEdit(cEditOptions)

        this.cEdit.SetFont(, DEFAULT_EDIT_FONT_NAME)
    }

    Update(newEditValue) {
        this.cEdit.Value := newEditValue
    }
}
