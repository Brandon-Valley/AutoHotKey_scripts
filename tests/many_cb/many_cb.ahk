
; https://www.hillelwayne.com/post/ahk-scripts-project/

#Requires AutoHotkey v2.0

/* A simple demo of how easy it is to write a GUI in AHK. This will allcaps any string you copy into the input.
You can run this script on its own, or from your main script with

    Run "autohotkey.exe " . A_WorkingDir . "\Lib\GUIs\Upcaser.ahk"

Keeping GUIs separate is good unless they need to share information with the main script.

READ MORE:
    - https://www.autohotkey.com/docs/v2/lib/Gui.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiOnEvent.htm
    - https://www.autohotkey.com/docs/v2/lib/GuiControls.htm
*/
#SingleInstance Force ; No others
#Include ClipboardHistory.ahk

; cb := Clipboard


App := Gui("Resize", "Clipboard Tools")
App.SetFont("s12")

og_clipboard_edit_opt_str := " r8 w300 -Wrap "

App.AddText(, "Original Clipboard:")
cClipboardEdit := App.AddEdit("ReadOnly " . og_clipboard_edit_opt_str) ;GUI widgets are called "controls", hence "cClipboardEdit"
cClipboardEdit.SetFont(, "Consolas")
cClipboardEdit.value := A_Clipboard


; Uppercase
App.AddText(,"Uppercase:")
; App.AddButton("Default w80", "Copy").OnEvent("Click", LoadFile)

cOutputEdit := App.AddText("ReadOnly " . og_clipboard_edit_opt_str)
cOutputEdit.SetFont(, "Consolas")
; cOutputEdit.BackColor := "00FF00"
; cOutputEdit.OnEvent("Click", CopyControlValueToClipboard_Click)
; cOutputEdit.On

cOutputEdit.value := StrUpper(cClipboardEdit.value)

; ; CopyControlValueToClipboard(controlObj) {
; ;     A_Clipboard := controlObj.value
; ; }

; CopyControlValueToClipboard_Click(*) {
;     msgBox("Pressed Button")
;     ; A_Clipboard := "SUCCESS"
; }

; ; MyBtn_Click(*) ;Function to be called when button pressed
; ; {
; ;     msgBox("Pressed Button")    
; ; }    
; ; myBtn := MyGui.AddButton(,"OOK") ;Adds an ok Button to the Gui
; ; myBtn.OnEvent("Click", MyBtn_Click) ;Call the function
; ; myGui.Show() ;Shows Gui




; Lowercase
; App.AddText("Section ys","Lowercase:") ; Start a new column within this section.
App.AddText("ys","Lowercase:") ; Start a new column within this section.
cOutputEdit := App.AddEdit("ReadOnly" . og_clipboard_edit_opt_str)
cOutputEdit.SetFont(, "Consolas")

cOutputEdit.value := StrLower(cClipboardEdit.value)










; Test

App.AddText(,"Test:") ; Start a new column within this section.
cOutputEdit := App.AddEdit("ReadOnly" . og_clipboard_edit_opt_str)
cOutputEdit.SetFont(, "Consolas")

tst:=ClipboardHistory.GetHistoryItemText(2)
cOutputEdit.value := tst



; for fmt in ClipboardHistory.GetAvailableFormats(2) { ; available formats of the second history item
;     formats .= fmt . '`n'
; }


GetCombinedClipboardHistoryStr(endStr := "---", cbItemSeperator := ",") {
    resultStr := ""
    i := 1
    while(1){
        cbItemText := ClipboardHistory.GetHistoryItemText(i)
        resultStr := resultStr . cbItemText
        msgBox resultStr
    }


    ; for cbHistoryItem in ClipboardHistory.GetAvailableFormats(2) { ; available formats of the second history item
    ;     formats .= fmt . '`n'
    ; }


    ; if !pIClipboardHistoryItem := this.GetClipboardHistoryItemByIndex(index)
    ;     return false
    ; bool := IClipboardStatics2.DeleteItemFromHistory(pIClipboardHistoryItem)
    ; ObjRelease(pIClipboardHistoryItem)
    ; return bool
}







; App.AddButton("Default w80", "Load File").OnEvent("Click", LoadFile)

; cClipboardEdit.OnEvent("Change", UpdateOutput) ; Triggered every time you type into the top box
App.OnEvent("Close", (*) => ExitApp(0))
App.OnEvent("Escape", (*) => ExitApp(0)) ; Close when you hit esc

App.Show()




; SetTextAndResize(controlHwnd, newText, fontOptions := "", fontName := "") {
;     Gui 9:Font, fontOptions, fontName
;     Gui 9:Add, "Text", "R1", newText
;     T := GuiControlGet("Pos", 9, "Static1")
;     Gui 9:Destroy
    
;     GuiControl("", controlHwnd, newText)
;     GuiControl("Move", controlHwnd, "h" . T.H . " w" . T.W)
; }




; =================================================================================
; Function: AutoXYWH
;   Move and resize control automatically when GUI resizes.
; Parameters:
;   DimSize - Can be one or more of x/y/w/h  optional followed by a fraction
;             add a '*' to DimSize to 'MoveDraw' the controls rather then just 'Move', this is recommended for Groupboxes
;             add a 't' to DimSize to tell AutoXYWH that the controls in cList are on/in a tab3 control
;   cList   - variadic list of GuiControl objects
;
; Examples:
;   AutoXYWH("xy", "Btn1", "Btn2")
;   AutoXYWH("w0.5 h 0.75", hEdit, "displayed text", "vLabel", "Button1")
;   AutoXYWH("*w0.5 h 0.75", hGroupbox1, "GrbChoices")
;   AutoXYWH("t x h0.5", "Btn1")
; ---------------------------------------------------------------------------------
; Version: 2023-02-25 / converted to v2 (Relayer)
;          2020-5-20 / small code improvements (toralf)
;          2018-1-31 / added a line to prevent warnings (pramach)
;          2018-1-13 / added t option for controls on Tab3 (Alguimist)
;          2015-5-29 / added 'reset' option (tmplinshi)
;          2014-7-03 / mod by toralf
;          2014-1-02 / initial version tmplinshi
; requires AHK version : v2+
; =================================================================================

AutoXYWH(DimSize, cList*)   ;https://www.autohotkey.com/boards/viewtopic.php?t=1079
{
    static cInfo := map()

    if (DimSize = "reset")
        Return cInfo := map()

    for i, ctrl in cList
    {
        ctrlObj := ctrl
        ctrlObj.Gui.GetPos(&gx, &gy, &gw, &gh)
        if !cInfo.Has(ctrlObj)
        {
            ctrlObj.GetPos(&ix, &iy, &iw, &ih)
            MMD := InStr(DimSize, "*") ? "MoveDraw" : "Move"
            f := map( "x", 0
                    , "y", 0
                    , "w", 0
                    , "h", 0 )

            for i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]"))) 
                if !RegExMatch(DimSize, "i)" . dim . "\s*\K[\d.-]+", &tmp)
                    f[dim] := 1
                else
                    f[dim] := tmp

            if (InStr(DimSize, "t"))
            {
                hWnd := ctrlObj.Hwnd
                hParentWnd := DllCall("GetParent", "Ptr", hWnd, "Ptr")
                RECT := buffer(16, 0)
                DllCall("GetWindowRect", "Ptr", hParentWnd, "Ptr", RECT)
                DllCall("MapWindowPoints", "Ptr", 0, "Ptr", DllCall("GetParent", "Ptr", hParentWnd, "Ptr"), "Ptr", RECT, "UInt", 1)
                ix := ix - NumGet(RECT, 0, "Int")
                iy := iy - NumGet(RECT, 4, "Int")
            }
            cInfo[ctrlObj] := {x:ix, fx:f["x"], y:iy, fy:f["y"], w:iw, fw:f["w"], h:ih, fh:f["h"], gw:gw, gh:gh, a:a, m:MMD}
        }
        else
        {
            dg := map( "x", 0
                     , "y", 0
                     , "w", 0
                     , "h", 0 )
            dg["x"] := dg["w"] := gw - cInfo[ctrlObj].gw, dg["y"] := dg["h"] := gh - cInfo[ctrlObj].gh
            ctrlObj.Move(  dg["x"] * cInfo[ctrlObj].fx + cInfo[ctrlObj].x
                         , dg["y"] * cInfo[ctrlObj].fy + cInfo[ctrlObj].y
                         , dg["w"] * cInfo[ctrlObj].fw + cInfo[ctrlObj].w
                         , dg["h"] * cInfo[ctrlObj].fh + cInfo[ctrlObj].h  )
            if (cInfo[ctrlObj].m = "MoveDraw")
                ctrlObj.Redraw()
        }
    }
}














; UpdateOutput(ctrl, unused) {
;     cOutputEdit.value := StrUpper(ctrl.value)
; }

; LoadFile(ctrl, unused) {
;     ; File selection is real easy in AHK!
;     ; READ MORE: https://www.autohotkey.com/docs/v2/lib/FileSelect.htm
;     file := FileSelect("1")
;     if file {
;         cClipboardEdit.value := FileRead(file)
;         UpdateOutput(cClipboardEdit, "unused")
;     }
; }












; Separate scripts can have hotkeys, too. 
; Below hotkey will be removed when ExitApp is called.

NumpadRight::MsgBox("This will be unbound when ExitApp(0) is called")