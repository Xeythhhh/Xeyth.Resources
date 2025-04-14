# -----------------------------------------------
# Xeyth PowerShell Profile Bootstrap
# Loads all .ps1 files from `.xeyth`, unblocks them if needed,
# and ensures script execution policy allows running them.
# -----------------------------------------------

#region Ensure Execution Policy is set to RemoteSigned for this user
try {
    $currentUserPolicy = Get-ExecutionPolicy -Scope CurrentUser

    if ($currentUserPolicy -ne "RemoteSigned") {
        Write-Host "[⚙] Setting ExecutionPolicy to RemoteSigned for CurrentUser..." -ForegroundColor Yellow
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
        Write-Host "[✓] ExecutionPolicy set. You may need to restart the shell once." -ForegroundColor Green
    }
} catch {
    Write-Host "[✗] Failed to set ExecutionPolicy: $_" -ForegroundColor Red
}
#endregion

#region Load and source each *.ps1 script from the .xeyth folder ("C:\Users\Xeyth\Documents\PowerShell\.xeyth")

# File prefix meaning (eg. {prefix}.PsReadLine.ps1)
# 0* - Global Constants / Shared Values
# 1* - Core
# 2* - Completions
# 3* - Theme

$profileDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path # Get the directory containing this profile script
$xeythModulesPath = Join-Path -Path $profileDirectory -ChildPath ".xeyth" # Define the path to the .xeyth module folder

if (Test-Path $xeythModulesPath) {

    # Get all .ps1 files recursively, sorted for predictable load order
    $xeythScripts = Get-ChildItem -Path $xeythModulesPath -Recurse -Filter "*.ps1" | Sort-Object FullName

    foreach ($script in $xeythScripts) {
        try {
			
            # If the script is marked as downloaded from the internet, unblock it. (These files live in a repository for easy setup across machines)
            $zoneIdentifier = "$($script.FullName):Zone.Identifier"
            if (Test-Path $zoneIdentifier) {
                Unblock-File $script.FullName
            }

            # Dot-source the script to bring it into the current session
            . $script.FullName

            # Strip ordering prefix and display information
            $scriptDisplayName = $script.BaseName -replace '^\d+\.', ''
            Write-Host "[✓] Loaded Xeyth Configuration: $scriptDisplayName.ps1" -ForegroundColor DarkGray
        } catch {
            Write-Host "[✗] Failed to load Xeyth Configuration script: $($script.Name)" -ForegroundColor Red
            Write-Host "    $_" -ForegroundColor Red
        }
    }

}

#endregion










# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}







