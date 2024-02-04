; #Include, AutoXYWH.ahk

; Gui, +Resize
; Gui, Add, Edit, ve1 w150 h100
; Gui, Add, Button, vb1 gResize, Resize
; Gui, Show
; return

; Resize:
;     GuiControl, Move, e1, h50
;     AutoXYWH("reset") ; Needs to reset if you changed the Control size manually.
; return
 
; GuiSize:
;     If (A_EventInfo = 1) ; The window has been minimized.
;         Return
;     AutoXYWH("wh", "e1")
;     AutoXYWH("y", "b1")
; return

#Requires AutoHotkey v2.0

; Define a function that takes another function as a parameter
PerformOperation(func, x, y) {
    ; Call the passed function with the provided arguments
    return func.Call(x, y)
}

; Define a function to be passed as a parameter
Add(x, y) {
    return x + y
}

; Call PerformOperation with the Add function and some arguments
; result := PerformOperation(Func("Add"), 5, 3)
result := PerformOperation(Add, 5, 3)

; Display the result
MsgBox result  ; Displays 8