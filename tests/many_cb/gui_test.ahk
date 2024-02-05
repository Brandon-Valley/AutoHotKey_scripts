; ; #Include, AutoXYWH.ahk

; ; Gui, +Resize
; ; Gui, Add, Edit, ve1 w150 h100
; ; Gui, Add, Button, vb1 gResize, Resize
; ; Gui, Show
; ; return

; ; Resize:
; ;     GuiControl, Move, e1, h50
; ;     AutoXYWH("reset") ; Needs to reset if you changed the Control size manually.
; ; return
 
; ; GuiSize:
; ;     If (A_EventInfo = 1) ; The window has been minimized.
; ;         Return
; ;     AutoXYWH("wh", "e1")
; ;     AutoXYWH("y", "b1")
; ; return

; #Requires AutoHotkey v2.0

; ; Define a function that takes another function as a parameter
; PerformOperation(func, x, y) {
;     ; Call the passed function with the provided arguments
;     return func.Call(x, y)
; }

; ; Define a function to be passed as a parameter
; Add(x, y) {
;     return x + y
; }

; ; Call PerformOperation with the Add function and some arguments
; ; result := PerformOperation(Func("Add"), 5, 3)
; result := PerformOperation(Add, 5, 3)

; ; Display the result
; MsgBox result  ; Displays 8


#Requires AutoHotkey v2.0
#SingleInstance Force ; No others

#Requires AutoHotkey v2.0


StrJoin(delimiter, arr) {
    ; Initialize an empty string
    str := ""

    ; Iterate over each item in the array
    for index, item in arr {
        ; Add the item to the string
        str .= item

        ; If this is not the last item, add the delimiter
        if (index < arr.Length)
            str .= delimiter
    }

    ; Return the joined string
    return str
}



AlignString(originalStr, targetStr) {
    ; Split the string into lines
    lines := StrSplit(originalStr, "`n", "`r")

    ; Initialize the maximum length
    maxLength := 0

    ; Find the maximum length before the targetStr character
    for line in lines {
        parts := StrSplit(line, targetStr)
        if (parts.Length >= 2 && StrLen(Trim(parts[1])) > maxLength)
            maxLength := StrLen(Trim(parts[1]))
    }

    ; Align each line based on the targetStr character
    for index, line in lines {
        parts := StrSplit(line, targetStr)
        if (parts.Length >= 2)
            lines[index] := Format("{: " maxLength "} " targetStr " {}", Trim(parts[1]), Trim(parts[2]))
    }

    ; Join the lines back into a string
    alignedStr := StrJoin("`n", lines)

    return alignedStr
}




; Test the function
originalStr :=("`napple = 1`nbanana = 2`ncherry = 3`n")

MsgBox AlignString(originalStr, "=")  ; Displays the aligned string
