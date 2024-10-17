#Requires Autohotkey v1.1
#SingleInstance, force

::fscb::
SendRaw, $(echo "" "Here is my current file structure:" "PWD: $PWD" $(Get-ChildItem -Recurse | Where-Object { !($_.FullName -match '\\\.pytest_cache\\') -and !($_.FullName -match '\\\.history\\') -and $_.Name -ne '__pycache__' -and !($_.Name -like '*.pyc')} | ForEach-Object { (Resolve-Path -Relative $_.FullName) -replace '_\d{14}', '' } | Sort-Object -Unique ) "")| clip
return