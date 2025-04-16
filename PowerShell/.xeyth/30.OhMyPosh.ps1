& {
	Test-Require-Command "oh-my-posh" "https://ohmyposh.dev/docs or e.g. 'choco install oh-my-posh'"
}

$directory = Split-Path -Parent $MyInvocation.MyCommand.Path
$configFile = Join-Path -Path $directory -ChildPath ".oh-my-posh\theme.json"

try {
	oh-my-posh init pwsh --config $configFile | Invoke-Expression
} catch {
	& ([ScriptBlock]::Create((oh-my-posh init pwsh --config $configFile --print) -join "`n"))
}
