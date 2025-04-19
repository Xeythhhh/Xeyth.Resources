# -----------------------------------------------
# Xeyth PowerShell Bootstrap
# -----------------------------------------------

# Initialize the global Xeyth object
$global:Xeyth = @{
    Config = $null
}

# Load paths and configuration
. (Join-Path -Path $PSScriptRoot -ChildPath "paths.ps1")
$global:Xeyth.Config = Get-Content -Path $global:Xeyth.Paths.Configuration -Raw | ConvertFrom-Json

# Load core modules

. (Join-Path -Path $global:Xeyth.Paths.Root -ChildPath "types.ps1")
. (Join-Path -Path $global:Xeyth.Paths.Root -ChildPath "security.ps1")
. (Join-Path -Path $global:Xeyth.Paths.Root -ChildPath "modules.ps1")
. (Join-Path -Path $global:Xeyth.Paths.Root -ChildPath "bootstrap.ps1")
