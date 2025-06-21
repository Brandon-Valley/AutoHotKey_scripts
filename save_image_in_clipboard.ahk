; ──────────────────────────────────────────────────────────────
; save_image_in_clipboard.ahk
;   • Saves the bitmap currently in the clipboard as a JPG
;   • Writes the full file path back to the clipboard
;   • Hotkey:  Ctrl + Alt + S
;   • No external libraries required
; ──────────────────────────────────────────────────────────────

#SingleInstance Force
#Persistent
SetBatchLines, -1
SendMode Input

; -------------------------------------------------------------
; Ctrl + Alt + S  →  save clipboard image to Pictures\Snips
; -------------------------------------------------------------
^!s::
{
    ; ─── 1. Verify clipboard holds a bitmap  ──────────────────
    if !DllCall("IsClipboardFormatAvailable", "UInt", 2) ; CF_BITMAP
    {
        MsgBox, 48, No image, Clipboard does not contain an image.
        return
    }

    ; ─── 2. Extract HBITMAP from clipboard  ──────────────────
    if !DllCall("OpenClipboard", "Ptr", 0)
    {
        MsgBox, 48, Error, Could not open clipboard.
        return
    }
    hBitmap := DllCall("GetClipboardData", "UInt", 2, "Ptr") ; CF_BITMAP
    DllCall("CloseClipboard")
    if !hBitmap
    {
        MsgBox, 48, Error, Failed to read bitmap from clipboard.
        return
    }

    ; ─── 3. Spin up GDI+  ────────────────────────────────────
    VarSetCapacity(si, 16, 0)
    NumPut(1, si, 0, "UInt")                         ; GdiplusStartupInput.GdiplusVersion = 1
    if DllCall("gdiplus\GdiplusStartup", "PtrP", pToken, "Ptr", &si, "Ptr", 0)
    {
        MsgBox, 48, Error, GDI+ failed to start.
        return
    }

    ; ─── 4. Turn HBITMAP → GDI+ Bitmap*  ─────────────────────
    if DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Ptr", hBitmap, "Ptr", 0, "PtrP", pBitmap)
    {
        DllCall("gdiplus\GdiplusShutdown", "Ptr", pToken)
        MsgBox, 48, Error, Could not create GDI+ bitmap.
        return
    }

    ; ─── 5. Get CLSID for JPEG encoder  ──────────────────────
    CLSID_JPEG := GetEncoderClsid("image/jpeg")
    if !CLSID_JPEG
    {
        CleanUp(pBitmap, pToken)
        MsgBox, 48, Error, JPEG encoder not found.
        return
    }

    ; ─── 6. Build output path  ───────────────────────────────
    FormatTime, ts,, yyyy-MM-dd_HH-mm-ss
    saveDir  := A_MyPictures "\Snips"
    FileCreateDir, %saveDir%
    savePath := saveDir "\snip_" . ts . ".jpg"

    ; ─── 7. Save the bitmap  ─────────────────────────────────
    if DllCall("gdiplus\GdipSaveImageToFile", "Ptr", pBitmap
                                           , "WStr", savePath
                                           , "Ptr", CLSID_JPEG
                                           , "Ptr", 0)
    {
        CleanUp(pBitmap, pToken)
        MsgBox, 48, Error, Failed to save image.
        return
    }

    ; ─── 8. Tidy up and put path on clipboard  ───────────────
    CleanUp(pBitmap, pToken)
    Clipboard := savePath
    ClipWait, 1
    MsgBox, 64, Saved, Image saved to:`n%savePath%`n`nPath copied to clipboard.
}
return

; -------------------------------------------------------------
; Helper: Shut down GDI+ and dispose image
; -------------------------------------------------------------
CleanUp(pBitmap, pToken)
{
    DllCall("gdiplus\GdipDisposeImage", "Ptr", pBitmap)
    DllCall("gdiplus\GdiplusShutdown", "Ptr", pToken)
}

; -------------------------------------------------------------
; Helper: Get encoder CLSID for a given MIME type
;          Works on both 32- and 64-bit AutoHotkey
; -------------------------------------------------------------
GetEncoderClsid(MimeType)
{
    ; Ask GDI+ how much space we need
    DllCall("gdiplus\GdipGetImageEncodersSize", "UIntP", count, "UIntP", bytes)
    if (count = 0)
        return 0

    VarSetCapacity(buf, bytes, 0)
    DllCall("gdiplus\GdipGetImageEncoders", "UInt", count, "UInt", bytes, "Ptr", &buf)

    ; Structure size differs between 32-bit (112) and 64-bit (120)
    structSize := (A_PtrSize = 8) ? 120 : 112
    ; Offset of MimeType pointer inside ImageCodecInfo
    mimePtrOff := (A_PtrSize = 8) ? 76 : 68

    Loop, % count
    {
        base := &buf + (A_Index - 1) * structSize
        mTypePtr := NumGet(base + mimePtrOff, "Ptr")
        if (StrGet(mTypePtr) = MimeType)
        {
            static clsid[16]
            DllCall("RtlMoveMemory", "Ptr", &clsid, "Ptr", base, "Ptr", 16)
            return &clsid
        }
    }
    return 0
}
