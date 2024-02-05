Gui := GuiCreate(, "Test")
Gui.BackColor := 000000

hTx1 := Gui.Add("Text", "BackgroundCFD8DC", "Edit Control:")
hTx1.SetFont("c263238")

hEdt1 := Gui.Add("Edit", "w400 r5 BackgroundE1BEE7", "Edit 1`nEdit 2`nEdit 3")
hEdt1.SetFont("c4A148C")

hEdt2 := Gui.Add("Edit", "w400 r5", "Edit 1`nEdit 2`nEdit 3")
hEdt2.SetFont("c0000FF")
hEdt2.Opt("Background00FFFF")

Gui.Add("Text", "BackgroundCFD8DC", "ComboBox Control:").SetFont("c263238")
Gui.Add("Combobox", "w400 BackgroundBBDEFB", "Combo 1||Combo 2|Combo 3|Combo 4").SetFont("c0D47A1")

Gui.Add("Text", "BackgroundCFD8DC", "ListBox Control:").SetFont("c263238")
Gui.Add("ListBox", "w400 r4 BackgroundB2DFDB", "ListBox 1||ListBox 2|ListBox 3|ListBox 4").SetFont("c004D40")

Gui.Add("Text", "BackgroundCFD8DC", "DropDownList Control:").SetFont("c263238")
Gui.Add("DropDownList", "w400 r4 BackgroundF0F4C3", "DropDownList 1||DropDownList 2|DropDownList 3|DropDownList 4").SetFont("c827717")

Gui.Add("Text", "BackgroundCFD8DC", "DropDownList Control (default):").SetFont("c263238")
Gui.Add("DropDownList", "w400 r4", "DropDownList 1||DropDownList 2|DropDownList 3|DropDownList 4").SetFont("c827717")

Gui.Add("Text", "BackgroundCFD8DC", "ListView Control:").SetFont("c263238")
;Gui.SetFont("cE65100")                                                                  ; works like the cXXXXXX option for LV
LV := Gui.Add("ListView", "w400 r10 BackgroundFFE0B2 cE65100", "Col 1|Col 2|Col 3")      ; .SetFont("") is not possible here
loop 5
	LV.Add(, A_Index, A_Index * 2, A_Index * 3)

Gui.Add("Button",, "Change Color").OnEvent("Click", "ChangeCtlColors")                   ; there is a white border around Buttons? Possible workaround -> WM_CTLCOLORBTN()

Gui.OnEvent("Close", "DeleteObjects")
Gui.Show()

ChangeCtlColors(this, *)
{
	global hEdt2                                                                         ; does I really need a global here to act with gui controls?
	hEdt2.Opt("BackgroundE7BEE1")
	hEdt2.SetFont("cFF0000")
}

DeleteObjects(this, *)
{
	if (hBrush)
		DllCall("gdi32\DeleteObject", "ptr", hBrush)
}

WM_CTLCOLORBTN(*)                                                                        ; this should be a build-in default for Button-Borders
{
	global hBrush
	static init   := OnMessage(0x0135, "WM_CTLCOLORBTN")
	return hBrush := DllCall("gdi32\CreateSolidBrush", "uint", 0x000000, "uptr")
}