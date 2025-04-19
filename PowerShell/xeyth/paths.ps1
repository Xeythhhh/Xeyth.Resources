# -----------------------------------------------
# Xeyth PowerShell Profile Paths
# Defines all relevant paths used in the profile
# -----------------------------------------------

# Base paths for the Xeyth module
$script:XeythRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# Configuration file for Xeyth settings and user preferences
$script:ConfigPath = Join-Path -Path $XeythRoot -ChildPath ".xeyth"
if (-not (Test-Path $ConfigPath)) { New-Item -ItemType File -Path $ConfigPath -Force | Out-Null }

# Module-related paths
$script:ModulesPath = Join-Path -Path $XeythRoot -ChildPath "modules"
$script:BootstrapScriptsPath = Join-Path -Path $XeythRoot -ChildPath "bootstrap"
$script:TestsPath = Join-Path -Path $BootstrapScriptsPath -ChildPath "tests"

# Initialize the Paths property in the global Xeyth object
$global:Xeyth.Paths = @{
    ProfileRoot = $XeythRoot
    Root = $XeythRoot
    Modules = $ModulesPath
    Bootstrap = $BootstrapScriptsPath
    Configuration = $ConfigPath
    Tests = $TestsPath
} 