& {
	class GitEditor {
		[ValidateNotNullOrEmpty()][string]$Tool
		[ValidateNotNullOrEmpty()][string]$Info
	
		GitEditor([string]$tool, [string]$info) {
			$this.Tool = $tool
			$this.Info = $info
		}
	}
	
	function Get-GitEditorBasedOnEnvironment([string]$parent) {
		$tool = ""; $info = ""
	
		switch -Regex ($parent) {
			{ $_ -match "Code" }            { $tool = "code --wait"   ; $info = "VS Code" }
			{ $_ -match "Cursor" }          { $tool = "cursor --wait" ; $info = "Cursor" }
			{ $_ -match "rider64" }         { $tool = "nano"          ; $info = "nano (via Rider)" }
			{ $_ -match "ServiceHub.Host" } { $tool = "nano"          ; $info = "nano (via Visual Studio)" }
			default                         { $tool = "nano"          ; $info = "nano (default)" }
		}
	
		return [GitEditor]::new($tool, $info)
	}
    
	function Set-GitEditorBasedOnEnvironment {
		$parent = (Get-Process -Id $PID).Parent.ProcessName
		$editor = Get-GitEditorBasedOnEnvironment $parent
		
		git config --global core.editor $editor.Tool
		return $editor.Info
	}

    ######################################################################

    Test-Require-Command git
    Test-Require-Command nano

    Set-GitEditorBasedOnEnvironment
}