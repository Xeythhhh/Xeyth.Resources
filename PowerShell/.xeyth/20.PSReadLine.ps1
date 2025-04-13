if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
    Write-Host "`n[⚠️ MISSING] PSReadLine module not found." -ForegroundColor [ConsoleColor]::Yellow
    Write-Host "→ Install via: Install-Module PSReadLine -Scope CurrentUser -Force" -ForegroundColor [ConsoleColor]::DarkGray
}

$TokenColors = @{
    "Command"          = [ConsoleColor]::Yellow
    "Parameter"        = [ConsoleColor]::DarkCyan
    "String"           = [ConsoleColor]::DarkGreen
    "Number"           = [ConsoleColor]::Magenta
    "Operator"         = [ConsoleColor]::DarkBlue
    "Variable"         = [ConsoleColor]::Green
    "Type"             = [ConsoleColor]::Cyan 
    "Comment"          = [ConsoleColor]::DarkGreen
    "Keyword"          = [ConsoleColor]::Blue
    "Error"            = [ConsoleColor]::Red       
    "Member"           = [ConsoleColor]::Gray
    "Emphasis"         = [ConsoleColor]::DarkYellow 
    "InlinePrediction" = [ConsoleColor]::DarkGray   
    "Default"          = [ConsoleColor]::White      
}

Set-PSReadLineOption -PredictionSource 'HistoryAndPlugin'
Set-PSReadLineOption -PredictionViewStyle 'ListView'
Set-PSReadLineOption -Colors $TokenColors

function xeyth-test::Test-PSReadLine-TokenColors {
    Write-Host "# Comment" -ForegroundColor $TokenColors["Comment"]
    Write-Host "'String Literal'" -ForegroundColor $TokenColors["String"]
    Write-Host "42" -ForegroundColor $TokenColors["Number"]
    Write-Host "=, +, -" -ForegroundColor $TokenColors["Operator"]
    Write-Host "$value" -ForegroundColor $TokenColors["Variable"]
    Write-Host "[string], [int]" -ForegroundColor $TokenColors["Type"]
    Write-Host "if, else, function" -ForegroundColor $TokenColors["Keyword"]
    Write-Host "Write-Host" -ForegroundColor $TokenColors["Command"]
    Write-Host "-Path, -Recurse" -ForegroundColor $TokenColors["Parameter"]
    Write-Host ".ToString(), .Length" -ForegroundColor $TokenColors["Member"]
    Write-Host "🔥 ERROR!" -ForegroundColor $TokenColors["Error"]
    Write-Host "!!!Important!!!" -ForegroundColor $TokenColors["Emphasis"]
    Write-Host "Ghost text prediction" -ForegroundColor $TokenColors["InlinePrediction"]
    Write-Host "This is plain text" -ForegroundColor $TokenColors["Default"]
}
