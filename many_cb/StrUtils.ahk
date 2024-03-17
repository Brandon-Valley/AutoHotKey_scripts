
MultiStrRemove(Haystack, SearchTexts) {
    return MultiStrReplace(Haystack, SearchTexts, ReplaceText := '')
}

MultiStrReplace(Haystack, SearchTexts, ReplaceText := '') {
    currentHaystack := Haystack

    for searchText in SearchTexts {
        currentHaystack := StrReplace(currentHaystack, searchText, ReplaceText)
    }

    return currentHaystack
}

GetLinesFromStr(originalStr, delimiter := "`n") {
    return StrSplit(originalStr, delimiter)
}

; ; @param func - must take 1 argument for current line
; GetStrAfterAppliedFuncToEachLine(originalStr, func) {
;     sep := "`n"
;     newStr := ""
;     lines := GetLinesFromStr(originalStr)
;     for line in lines {
;         newLine := func(line)
;         newStr := newStr . newLine . sep
;     }
;     return SubStr(newStr, 1, -StrLen(sep))
; }

; @param func - must take 1 argument for current line
GetStrAfterAppliedFuncToEachLine(originalStr, func) {
    return GetStrAfterAppliedFuncToEachSeperatedSection(originalStr, func, "`n")
}

GetStrAfterWrapEachLineWithStr(originalStr, wrapStr) {
    return GetStrAfterWrapEachSeperatedSectionWithStr(originalStr, wrapStr, sep:= "`n")
}

GetStrAfterAddStrToEndOfEachLine(originalStr, AddStr, sep:= "`n") {
    return GetStrAfterAddStrToEndOfEachSeperatedSectionWithStr(originalStr, AddStr, sep:= "`n")
}

GetStrAfterAddStrToStartOfEachLine(originalStr, AddStr, sep:= "`n") {
    return GetStrAfterAddStrToStartOfEachSeperatedSectionWithStr(originalStr, AddStr, sep:= "`n")
}

GetStrAfterAddStrToStartOfEachSeperatedSectionWithStr(originalStr, AddStr, sep:= "`n") {
    _Func(line) {
        return AddStr . line
    }
    return GetStrAfterAppliedFuncToEachSeperatedSection(originalStr, _Func, sep)
}

GetStrAfterAddStrToEndOfEachSeperatedSectionWithStr(originalStr, AddStr, sep:= "`n") {
    _Func(line) {
        return line . AddStr
    }
    return GetStrAfterAppliedFuncToEachSeperatedSection(originalStr, _Func, sep)
}

GetStrAfterWrapEachSeperatedSectionWithStr(originalStr, wrapStr, sep:= "`n") {
    _Wrap(line) {
        return wrapStr . line . wrapStr
    }
    return GetStrAfterAppliedFuncToEachSeperatedSection(originalStr, _Wrap, sep)
}

; @param func - must take 1 argument for current line
GetStrAfterAppliedFuncToEachSeperatedSection(originalStr, func, sep := "`n") {
    sep := "`n"
    newStr := ""
    lines := GetLinesFromStr(originalStr)
    for line in lines {
        newLine := func(line)
        newStr := newStr . newLine . sep
    }
    return SubStr(newStr, 1, -StrLen(sep))
}








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


AlignStr(originalStr, targetStr) {
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

