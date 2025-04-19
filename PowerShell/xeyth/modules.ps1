# -----------------------------------------------
# Xeyth PowerShell Module Loading
# Loads all XPS modules from `xeyth/modules/`
# -----------------------------------------------

foreach ($module in Get-ChildItem -Path $global:Xeyth.Paths.Modules -Filter "*.psd1" | Sort-Object FullName) {
    Import-Module $module -Force
} 