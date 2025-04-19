# -----------------------------------------------
# Xeyth PowerShell Profile Paths
# Defines all relevant paths used in the profile
# -----------------------------------------------

# Base paths for the Xeyth module
$script:XeythRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# Module-related paths
$script:ModulesPath = Join-Path -Path $XeythRoot -ChildPath "modules"
$script:BootstrapScriptsPath = Join-Path -Path $XeythRoot -ChildPath "bootstrap"
$script:TestsPath = Join-Path -Path $BootstrapScriptsPath -ChildPath "tests"

# Initialize the Paths property in the global Xeyth object
$Xeyth.XPS.Paths = @{
    Root = $XeythRoot
    Modules = $ModulesPath
    Bootstrap = $BootstrapScriptsPath
    Tests = $TestsPath
} 