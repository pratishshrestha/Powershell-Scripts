function QueryfromRange {
	[CmdletBinding()]
    $result = @()       
    $exclude = Get-Content C:\Temp\RemoteComputers.txt
    $first = Read-Host "What is the first machine name?"
    $last = Read-Host "What is the last machine name?"

    try {
        if(($first.Substring(0,7) -eq $last.Substring(0,7)) -and ($first.Substring(7,3), $last.Substring(7,3) -match '\d\d\d')){
            $from = [int]$first.Substring(($first.Length) - 3)               ## Getting the last 3 digits of the user input and storing it to $from
            $last = [int]$last.Substring(($last.Length) - 3)                 ## Getting the last 3 digits of the user input and storing it to $last
            for ($i = $from; $i -le $last; $i+=1){
                $f = '{0:d3}' -f $i                                          ## Adding preceding 0's if one or two digit number, for eg. 1 is 001, 12 is 012   
                $result += @($first.Substring(0,7) + $f)                     ## Getting all the computers between first and last computer name on a result array
            }
            $result = $result | Where-Object {$_ -notin $exclude}            ## making sure the file's computer list are ommitted
            $result | ForEach-Object {
                try {
                    $resultnumber = $_
                    Write-Host "##############################   $resultnumber      ###############################"
                    Start-Sleep -Seconds 3
                    Invoke-Command -ComputerName $_ -ScriptBlock {query user} -ErrorAction Stop
                    Write-Host "`n"
                }
                catch {
                    Write-Host "$resultnumber is offline"
                    Write-Host "`n"
                }
            }
            Read-Host -Prompt "Press Enter to exit..."
        }
        else{
        Write-Host "ERROR format doesn't match, correct format two numbers: mel-ws-XXX, mel-ws-XXX or mel-tb-XXX, mel-tb-XXX, where XXX must be three digits, also you can't leave the field of first and last machine name empty"
        Read-Host -Prompt "Press Enter to exit..."
        }
    }  
    catch {
    {"ERROR because the prefix doesn't match, correct format: MEL-WS-XXX, XXX=3 digits are necessary"
    Read-Host -Prompt "Press Enter to exit..."}
    }
}

function QueryfromFile{

    $result = @(Get-Content C:\Temp\RemoteComputers.txt)
    $result | ForEach-Object{
        if($_ -imatch '(\bmel\b|\bsyd\b|\bcan\b|\bade\b|\bper\b|\bbri\b)-(\bws\b|\brw\b|\bnb\b)-\d\d\d$'){
            try {
                $resultnumber = $_
                Write-Host "##############################   $resultnumber      ###############################"
                Start-Sleep -Seconds 3
                Invoke-Command -ComputerName $_ -ScriptBlock {query user} -ErrorAction Stop
                Write-Host "`n"
            }
            catch {
                Write-Host "$resultnumber is offline"
                Write-Host "`n"
            }
        }
    }
    Read-Host -Prompt "Press Enter to exit..."

}

function checkFileexist{
    $fileExist = Test-Path -Path C:\temp\RemoteComputers.txt -PathType Leaf              ## Test if the file exist with true or false msg
    if($fileExist -eq $true){
        $userPressed = Read-Host "What would you like to do? [Enter 1 or 2]`n`n 1.Provide range of the computers and exclude some computers provided in the file C:\Temp\RemoteComputers.txt.`n 2.Run this command on specific computers provided in the file C:\Temp\RemoteComputers.txt.`n"
        if ($userPressed -eq '1'){QueryfromRange}
        elseif ($userPressed -eq '2') {QueryfromFile}
    }
    else{
        New-Item -ItemType "file" -Path C:\Temp\RemoteComputers.txt | Out-Null            ## New-Item gives a notification, out-null avoids it
        Write-Host "*****************   File has been created, please edit the file and try to run script again   **********************"
        Write-Host "Edit a file under C:\Temp\RemoteComputers.txt to exclude them and type the name of the computer followed by enter. Example:"
        Write-Host "mel-ws-256"
        Write-Host "mel-ws-300"
        Read-Host -Prompt "Press Enter to exit..."
    }
}

checkFileexist



