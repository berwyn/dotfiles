Remove-Alias "cat"
Set-Alias -Name "cat" -Value "bat"

rustup completions powershell | Out-String | Invoke-Expression
& starship init powershell | Invoke-Expression