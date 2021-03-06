
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


Write-host "Getting Last Boot Time"
$last_boot_object = Get-CimInstance -ClassName win32_operatingsystem | select LastBootUpTime

$last_boot = $last_boot_object.LastBootUpTime.Day.ToString() + '/' + $last_boot_object.LastBootUpTime.
Month.ToString() + '/' + $last_boot_object.LastBootUpTime.Year.ToString()

Write-host "Last boot time: " $last_boot
Get-CimInstance Win32_OperatingSystem | FL *
