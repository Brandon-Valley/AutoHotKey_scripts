; ; autohotkey script to prompt chatgpt to give answer to leetcode question saved in clipboard using this format ONLY for the answer:

; ; # Intuition
; ; <!-- Describe your first thoughts on how to solve this problem. -->

; ; # Approach
; ; <!-- Describe your approach to solving the problem. -->

; ; # Complexity
; ; - Time complexity:
; ; <!-- Add your time complexity here, e.g. $$O(n)$$ -->

; ; - Space complexity:
; ; <!-- Add your space complexity here, e.g. $$O(n)$$ -->

; ; # Code
; ; ```
; ; ```

; ::gptplc::
; clipboard := ""  ; Clear the clipboard
; SendInput, ^c  ; Copy the selected text
; ClipWait  ; Wait for the clipboard to contain data

; ; Prompt ChatGPT to provide an answer in the specified format
; SendInput, /prompt Hey ChatGPT, can y/prompt h/epyr /o/cpphmraportom/ MPGhPTP?Ptpre,ro yt omholution for this LeetCode problem using the following format?`n``n# Intuition`n<!-- Describe your first thoughts on how to solve this problem. -->`n`n# Approach`n<!-- Describe your approach to solving the problem. -->`n`n# Complexity`n- Time complexity:`n<!-- Add your time complexity here, e.g. $$O(n)$$ -->`n`n- Space complexity:`n<!-- Add your space complexity here, e.g. $$O(n)$$ -->`n`n# Code`n````n%clipboard%
; return