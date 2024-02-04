
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