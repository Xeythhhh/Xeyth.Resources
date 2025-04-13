$directory = Split-Path -Parent $MyInvocation.MyCommand.Path
$configFile = Join-Path -Path $directory -ChildPath "Configuration\oh-my-posh.json"

try {
	oh-my-posh init pwsh --config $configFile | Invoke-Expression
} catch {
	Write-Host "Failed to initialize oh-my-posh, attempting fallback!"  -ForegroundColor [ConsoleColor]::Yellow -BackgroundColor [ConsoleColor]::DarkRed
	& ([ScriptBlock]::Create((oh-my-posh init pwsh --config $configFile --print) -join "`n"))
}
