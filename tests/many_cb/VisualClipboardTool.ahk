#Requires AutoHotkey v2.0

DEFAULT_EDIT_FONT_NAME := "Consolas"

COLOR_HEX_UPDATED := "e2efda"
COLOR_HEX_NOT_UPDATED := "fce4d6"

INITIAL_EDIT_VALUE := "INITAL_EDIT_VALUE!"

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
    __new(guiObject, cTextOptions, cEditOptions, cTextText, exemptFromUpdateCheck := 0) {
        this.exemptFromUpdateCheck := exemptFromUpdateCheck
        this.cText := guiObject.AddText(cTextOptions, cTextText)
        this.cEdit := guiObject.AddText(cEditOptions)
        ; this.trueValue := A_Clipboard

        this.cEdit.SetFont(, DEFAULT_EDIT_FONT_NAME)




        this.cEdit.OnEvent("Click", this._SingleClick)
    }

    Update(newEditValue) {
        if (this.exemptFromUpdateCheck) {
            this.cEdit.Value := newEditValue
            return
        }

        ; if (this.trueValue == newEditValue) {
        if (A_Clipboard == newEditValue) {
            this.cEdit.Opt("Background" . COLOR_HEX_NOT_UPDATED)
            this.cEdit.Value := ""
            return
        }

        this.cEdit.Opt("Background" . COLOR_HEX_UPDATED)
        this.cEdit.Value := newEditValue
        ; this.trueValue  := newEditValue
    }

    _SingleClick(unusedParamNeededForOnClipboardChange?) {
        ;B/c of how this is called, this.cEdit == this
        A_Clipboard := this.Value
        ;TODO flash color change for feedback
    }
}
