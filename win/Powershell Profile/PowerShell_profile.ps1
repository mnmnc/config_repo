
cls
Write-host " "

Write-host -ForegroundColor Gray " LOADING PROFILE..."
function msed (){
    $input | sed 's/ */ /g'
}
Write-host -NoNewLine -ForegroundColor Gray "    LOADING FUNCTION "
Write-host -NoNewLine -ForegroundColor White "msed"
Write-host -ForegroundColor DarkGray "               - sed 's/ */ /g'"

function Prompt(){
    $time = [string]( Get-Date -UFormat %R)
    $current = get-location
    $username = $env:USERNAME
    $computer = ($env:COMPUTERNAME).ToUpper()
    Write-host -NoNewline -ForegroundColor White " $time"
    Write-host -NoNewline " "
    Write-host -NoNewline -ForegroundColor Red "$computer"
    Write-host -NoNewline " "
    Write-host -NoNewLine -ForegroundColor Gray $current
    Write-host -NoNewline " "
    Write-host -NoNewline ">"
    return " "
}
Write-host -NoNewLine -ForegroundColor Gray "    LOADING FUNCTION "
Write-host -NoNewLine -ForegroundColor White "Prompt "
Write-host -ForegroundColor DarkGray "            - sets custom powershell prompt."

function cta(){
    Write-host -ForegroundColor Gray "    TRYING TO ESTABLISH CONNECTION WITH AD DOMAIN ..."
    $DOMAIN = New-Object System.DirectoryServices.DirectoryEntry("LDAP://OU=US,OU=Employees,DC=domain,DC=com")
    if ( $DOMAIN ){
        $c = [char]16
        Write-host -NoNewLine -ForegroundColor Green "     $c"
        Write-host -ForegroundColor DarkGray " `$DOMAIN variable available."
    }
    else {
        $c = [char]16
        Write-host -NoNewLine -ForegroundColor Red  "     $c"
        Write-host -ForegroundColor DarkGray " Could not connect to AD."
            $global:SUCCESS = 0;
        }
    return $DOMAIN
}

Write-host -NoNewline -ForegroundColor Gray "    LOADING FUNCTION "
Write-host -NoNewline -ForegroundColor White "cta"
Write-host -ForegroundColor DarkGray "                - used to establish connection to domain controller."

function sen([string]$userid){
    # IF CONNECTED
    if ( $DOMAIN ){ 
        $FILTER = "(&(cn=$userid))";
        $Searcher = New-Object System.DirectoryServices.DirectorySearcher
        $Searcher.SearchRoot = $DOMAIN
        $Searcher.PageSize = 10
        $Searcher.Filter = $FILTER
        $Searcher.SearchScope = "Subtree"

        # WHAT TO COLLECT
        $PROPERTIES = "mail", "displayName", "department", "description", "JobRole", "level", "houseIdentifier", "lastLogonTimestamp", "postOfficeBox", "telephoneNumber"
        foreach ($i in $PROPERTIES){
            $Searcher.PropertiesToLoad.Add($i) | Out-null
        }

        # FETCH
        $RESULTS = $Searcher.FindAll()
        if ( $RESULTS -ne $null ){
            foreach ($OBJ in $RESULTS)
            {
                $USER = $OBJ.Properties;
                
                $dn = $USER.'displayname'
                $dept = $USER.'department'
                $desc = $USER.'description'
                $job = $USER.'jobrole'
                $level = $USER.'level'
                $location = $USER.'houseidentifier'
                $mail = $USER.'mail'
                $floor = $USER.'postofficebox'
                $phone = $USER.'telephonenumber'
                $lastlogon_time = [int64](($USER.'lastlogontimestamp')[0])
                $lastlogon = [datetime]::FromFileTime($lastlogon_time).ToString('dd/M/yyyy HH:mm:ss ') 
                
                Write-host "$userid | $dept | $desc | $level | $lastlogon| $dn | $mail | $job | $location | $floor | $phone "
                
            }
        }
        else {
            $global:SUCCESS = 0;
            Write-host -NoNewline -ForegroundColor Red "`tNOT FOUND`tUSERID: " $userid "`t" 
        }
    }
    else {
        $global:SUCCESS = 0;
        Write-host -ForegroundColor DarkYellow "`rDOMAIN CONNECTION FAILURE`r";
    }
}

Write-host -NoNewline -ForegroundColor Gray "    LOADING FUNCTION "
Write-host -NoNewline -ForegroundColor White "sen( USERID )"
Write-host -ForegroundColor DarkGray "      - gets user details from AD for a given USERID."

function ses([string]$surname){
    # IF CONNECTED
    if ( $DOMAIN ){ 
        $FILTER = "(&(sn=$surname))";
        $Searcher = New-Object System.DirectoryServices.DirectorySearcher
        $Searcher.SearchRoot = $DOMAIN
        $Searcher.PageSize = 10
        $Searcher.Filter = $FILTER
        $Searcher.SearchScope = "Subtree"

        # WHAT TO COLLECT
        $PROPERTIES = "cn", "mail", "displayName", "department", "description", "JobRole", "level", "houseIdentifier", "lastLogonTimestamp", "postOfficeBox", "telephoneNumber"
        foreach ($i in $PROPERTIES){
            $Searcher.PropertiesToLoad.Add($i) | Out-null
        }

        # FETCH
        $RESULTS = $Searcher.FindAll()
        if ( $RESULTS -ne $null ){
            foreach ($OBJ in $RESULTS)
            {
                $USER = $OBJ.Properties;
                $userid = $USER.'cn'
                $dn = $USER.'displayname'
                $dept = $USER.'department'
                $desc = $USER.'description'
                $job = $USER.'jobrole'
                $level = $USER.'level'
                $location = $USER.'houseidentifier'
                $mail = $USER.'mail'
                $floor = $USER.'postofficebox'
                $phone = $USER.'telephonenumber'
                $lastlogon_time = [int64](($USER.'lastlogontimestamp')[0])
                $lastlogon = [datetime]::FromFileTime($lastlogon_time).ToString('dd/M/yyyy HH:mm:ss ') 
                
                Write-host "$userid | $dept | $desc | $level | $lastlogon| $dn | $mail | $job | $location | $floor | $phone | "
                
            }
        }
        else {
            $global:SUCCESS = 0;
            Write-host -NoNewline -ForegroundColor Red "`tNOT FOUND`tSURNAME: " $surname "`t" 
        }
    }
    else {
        $global:SUCCESS = 0;
        Write-host -ForegroundColor DarkYellow "`nDOMAIN CONNECTION FAILURE`n";
    }
}

Write-host -NoNewline -ForegroundColor Gray "    LOADING FUNCTION "
Write-host -NoNewline -ForegroundColor White "sen( SURNAME )"
Write-host -ForegroundColor DarkGray "     - gets user details from AD for a given SURNAME."

# CONNECTING TO DOMAIN
$DOMAIN = cta

Write-host -NoNewline -ForegroundColor Gray "`n PROFILE LOADED."
Write-host -ForegroundColor Yellow " Happy hunting!`r`n"



