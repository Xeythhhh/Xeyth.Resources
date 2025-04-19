# Public requirement check
XPSRequireCommand "oh-my-posh" "e.g. 'scoop install oh-my-posh'`nYou can use scoop or choco for Windows`nhttps://ohmyposh.dev/docs"

$script:configFile = Join-Path -Path $global:Xeyth.Paths.Bootstrap -ChildPath ".oh-my-posh\theme.json"

try {
	# First attempt: Try to initialize and invoke directly
	oh-my-posh init pwsh --config $script:configFile | Invoke-Expression
} catch {
	# Second attempt: If direct invocation fails, create and invoke a script block
	& ([ScriptBlock]::Create((oh-my-posh init pwsh --config $script:configFile --print) -join "`n"))
}
