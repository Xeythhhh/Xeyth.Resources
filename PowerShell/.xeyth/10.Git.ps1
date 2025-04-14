& {
    function Set-GitEditorBasedOnEnvironment {
        switch -Regex ((Get-Process -Id $PID).Parent.ProcessName) {
            { $_ -match "Code" }            { git config --global core.editor "code --wait";   return "Git editor set to: VS Code" }
            { $_ -match "Cursor" }          { git config --global core.editor "cursor --wait"; return "Git editor set to: Cursor" }
            { $_ -match "rider64" }         { git config --global core.editor "nano";          return "Git editor set to: nano (via Rider)" }
            { $_ -match "ServiceHub.Host" } { git config --global core.editor "nano";          return "Git editor set to: nano (via Visual Studio)" }
            default                         { git config --global core.editor "nano";          return "Git editor set to: nano (default)" }
        }
        
    }

    ######################################################################

    Test-Require-Command git
    Test-Require-Command nano

    Set-GitEditorBasedOnEnvironment
}
