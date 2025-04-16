# -----------------------------------------------
# Xeyth PowerShell Profile Bootstrap
# Loads all .ps1 files from `.xeyth`, unblocks them if needed,
# and ensures script execution policy allows running them.
# -----------------------------------------------

# Define Bootstrap functions

function Write-StatusMessage {
    param(
        [string]$Message,
        [string]$Symbol = "✓",
        [ConsoleColor]$SymbolColor = "Green",
        [ConsoleColor]$MessageColor = "DarkGray"
    )

    Write-Host "[" -NoNewline -ForegroundColor DarkGray
    Write-Host "$Symbol" -NoNewline -ForegroundColor $SymbolColor 
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host $Message -ForegroundColor $MessageColor
}

function Write-StatusError {
    param(
        [string]$Message
    )
    Write-StatusMessage $Message -Symbol "✗" -SymbolColor DarkRed -MessageColor DarkRed
}

function Test-Require-Command($cmd, $helpUrl) {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        throw "[⚠️ MISSING] Required command '$cmd' not found.`n→ Install: $helpUrl"
    }
}

# Ensure Execution Policy is set to RemoteSigned for this user
try {
    $currentUserPolicy = Get-ExecutionPolicy -Scope CurrentUser

    if ($currentUserPolicy -ne "RemoteSigned") {
        Write-StatusMessage "Setting ExecutionPolicy to RemoteSigned for CurrentUser..." -Symbol "⚙" -SymbolColor Yellow -MessageColor Yellow
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
        Write-StatusMessage "ExecutionPolicy set. You may need to restart the shell once."
    }
} catch {
    Write-StatusError "Failed to set ExecutionPolicy: $_"
}

# Load and source each *.ps1 script from the .xeyth folder ("C:\Users\Xeyth\Documents\PowerShell\.xeyth")

# File prefix meaning (eg. {prefix}.PsReadLine.ps1)
# 0* - Global Constants / Shared Values
# 1* - Core
# 2* - Completions
# 3* - Theme

$profileDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path # Get the directory containing this profile script
$xeythModulesPath = Join-Path -Path $profileDirectory -ChildPath ".xeyth" # Define the path to the .xeyth module folder

if (Test-Path $xeythModulesPath) {
    Write-Host "Loading profile..." -ForegroundColor DarkGray

    # Get all .ps1 files in "./.xeyth/" sorted for predictable load order
    $xeythScripts = Get-ChildItem -Path $xeythModulesPath -Filter "*.ps1" | Sort-Object FullName

    foreach ($script in $xeythScripts) {

        # Strip ordering prefix and display information
        $scriptDisplayName = $script.BaseName -replace '^\d+\.', ''

        if ($global:XeythLoadedScripts -contains $script.FullName) { continue }

        try {
            
            # If the script is marked as downloaded from the internet, unblock it. (These files live in a repository for easy setup across machines)
            $zoneIdentifier = "$($script.FullName):Zone.Identifier"
            if (Test-Path $zoneIdentifier) {
                Unblock-File $script.FullName
            }

            # Dot-source the script to bring it into the current session
            $output = . $script.FullName

            Write-StatusMessage "Loaded: $scriptDisplayName"
            if ($output) {
                $output.split("`n", [System.StringSplitOptions]::RemoveEmptyEntries) | ForEach-Object { Write-Host "    > $_" -ForegroundColor DarkGray }
            }

            $global:XeythLoadedScripts += $script.FullName

        } catch {
            Write-StatusError "Failed to load: $scriptDisplayName"
            $_.ToString().split("`n", [System.StringSplitOptions]::RemoveEmptyEntries) | ForEach-Object {
                Write-Host "    > " -ForegroundColor DarkGray -NoNewline
                Write-Host "$_" -ForegroundColor Red
            }
        }
    }

}










# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}







