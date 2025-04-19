# -----------------------------------------------
# Xeyth PowerShell Security Settings
# Configures security-related settings like ExecutionPolicy
# -----------------------------------------------

# Ensure Execution Policy is set to RemoteSigned for this user
try {
    $currentUserPolicy = Get-ExecutionPolicy -Scope CurrentUser

    if ($currentUserPolicy -ne "RemoteSigned") {
        Write-Warning "Setting ExecutionPolicy to RemoteSigned for CurrentUser..." -Symbol "⚙" -SymbolColor Yellow -MessageColor Yellow
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
        Write-Warning "ExecutionPolicy set. You may need to restart the shell once." -MessageColor Green
    }
} catch { Write-Warning "Failed to set ExecutionPolicy: $_" } 