#Requires AutoHotkey v2.0


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



    __new(func, guiObject, cNewTextOptions, cNewTextText, cNewEditOptions, cNewEditFontName := "Consolas") {
        cNewText := guiObject.AddText(cNewTextOptions, cNewTextText)
        cNewEdit := guiObject.AddEdit(cNewEditOptions)
        cNewEdit.SetFont(, cNewEditFontName)
        
        UpdateEditControlValue(unusedParamNeededForOnClipboardChange) {
            ; cNewEdit.value := "CLIPBOARD UPDATED"
            cNewEdit.value := func()
        }
        OnClipboardChange UpdateEditControlValue

        

        ; ; cNewEdit.value := func.Call()
        



        ; ; OnClipboardChange UpdateEditControlValue
        ; ; OnClipboardChange func.Call()



        ; ; Define a function that takes another function as a parameter
        ; PerformOperation(func, x, y) {
        ;     ; Call the passed function with the provided arguments
        ;     return func.Call(x, y)
        ; }

        ; ; Define a function to be passed as a parameter
        ; Add(x, y) {
        ;     return x + y
        ; }

        ; ; Define a function to be called when the clipboard changes
        ; Update() {

        ;     cNewEdit.value := "CLIPBOARD UPDATED"
        ;     ; Call PerformOperation with the Add function and some arguments
        ;     result := PerformOperation(Func("Add"), 5, 3)

        ;     ; Display the result
        ;     MsgBox result  ; Displays 8
        ; }

        ; ; Set the OnClipboardChange function to be called when the clipboard changes
        ; OnClipboardChange := Update

    }

}

; class ClipboardTool {
;     static __new(toolOutputStr, guiObject, cNewTextOptions, cNewTextText, cNewEditOptions, cNewEditFontName := "Consolas") {

;         this.name := AppName

;     }
   
;     static Msg() {

;         MsgBox("My application name is: " this.name)

;     }


; } 