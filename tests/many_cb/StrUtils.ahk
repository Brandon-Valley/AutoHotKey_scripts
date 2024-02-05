
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
