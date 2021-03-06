
Write-host -ForegroundColor Yellow "LOADING PROFILE..."

function msed (){
    $input | sed 's/  */ /g'
    
}
Write-host -ForegroundColor Yellow "MSED LOADED. > sed 's/  */ /g'"

function Prompt(){
    $time = [string]( Get-Date -UFormat %R)
    $current = get-location
    $username = $env:USERNAME
    $computer = ($env:COMPUTERNAME).ToLower()
     
    Write-host -NoNewline -ForegroundColor White $time
    Write-host -NoNewline " "
    Write-host -NoNewline -ForegroundColor Red "$computer"
    Write-host -NoNewline " "
    Write-host -NoNewLine -ForegroundColor Gray $current
    Write-host -NoNewline " "
    Write-host -NoNewline ">"
    return " "
}