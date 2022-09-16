# Creates a bookmark html of Chrome and stores in C:\Temp drive of the new computer of the user
# and also saves in OneDrive folder of the user

# make sure both the computer are online and logged in by the user
$oldComputer = Read-Host("What's the old computer name?")
$newComputer = Read-Host("What's the new computer name?")
try {
    $username = (Get-Wmiobject -cn $oldComputer -class Win32_ComputerSystem | Select-Object username).username.Split("\")[1]
}
catch {
    Write-Host "Make sure that the user is logged-in on $oldComputer" -ForegroundColor White -BackgroundColor Red
    break
}

function Bookmarks {
    if (Test-Connection -cn $oldComputer -Quiet -Count 1){
        if ($oldComputer -imatch '(\bmel\b|\bsyd\b|\bcan\b|\bade\b|\bper\b|\bbri\b)-(\bws\b|\brw\b|\bnb\b|\btb\b|\brn\b)-\d\d\d$'){
            # $username = (Get-Wmiobject -cn $oldComputer -class Win32_ComputerSystem | Select-Object username).username.Split("\")[1]
            New-Item "\\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\ChromeBookmark" -ItemType Directory -Force | Out-Null
            $pathToJsonFile = "\\$oldComputer\C$\Users\$username\AppData\Local\Google\Chrome\User Data\Default\Bookmarks"
            $htmlOut = "\\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\ChromeBookmark\ChromeBookmarks.html"
            $htmlOut1 = "\\$newComputer\C$\Temp\ChromeBookmarks.html"
            $htmlHeader = @"
        
            <!DOCTYPE NETSCAPE-Bookmark-file-1>
            <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
            <Title>Bookmarks</Title>
            <H1>Bookmarks</H1>
            <DL><p>
"@
            $htmlHeader | Out-File -FilePath $htmlOut -Force -Encoding utf8 #line59
            $htmlHeader | Out-File -FilePath $htmlOut1 -Force -Encoding utf8
        
            #A nested function to enumerate bookmark folders
            Function Get-BookmarkFolder {
            [cmdletbinding()]
            Param(
            [Parameter(Position=0,ValueFromPipeline=$True)]
            $Node
            )
        
            Process 
            {
        
            foreach ($child in $node.children) 
            {
            $da = [math]::Round([double]$child.date_added / 1000000) #date_added - from microseconds (Google Chrome {dates}) to seconds 'standard' epoch.
            # $dm = [math]::Round([double]$child.date_modified / 1000000) #date_modified - from microseconds (Google Chrome {dates}) to seconds 'standard' epoch.
            if ($child.type -eq 'Folder') 
            {
                "    <DT><H3 FOLDED ADD_DATE=`"$($da)`">$($child.name)</H3>" | Out-File -FilePath $htmlOut -Append -Force -Encoding utf8
                "       <DL><p>" | Out-File -FilePath $htmlOut -Append -Force -Encoding utf8
                "       <DL><p>" | Out-File -FilePath $htmlOut1 -Append -Force -Encoding utf8
                Get-BookmarkFolder $child
                "       </DL><p>" | Out-File -FilePath $htmlOut -Append -Force -Encoding utf8
                "       </DL><p>" | Out-File -FilePath $htmlOut1 -Append -Force -Encoding utf8
            }
            else 
            {
                    "       <DT><a href=`"$($child.url)`" ADD_DATE=`"$($da)`">$($child.name)</a>" | Out-File -FilePath $htmlOut -Append -Encoding utf8
                    "       <DT><a href=`"$($child.url)`" ADD_DATE=`"$($da)`">$($child.name)</a>" | Out-File -FilePath $htmlOut1 -Append -Encoding utf8
            } #else url
            } #foreach
            } #process
            } #end function
            if(Test-Path $("filesystem::\\$oldcomputer\C$\Users\$username\AppData\Local\Google\Chrome\User Data\Default\Bookmarks")){
                $data = Get-content $pathToJsonFile -Encoding UTF8 | out-string | ConvertFrom-Json
                $sections = $data.roots.PSObject.Properties | Select-Object -ExpandProperty name
                ForEach ($entry in $sections) {
                    $data.roots.$entry | Get-BookmarkFolder
                }
                '</DL>' | Out-File -FilePath $htmlOut -Append -Force -Encoding utf8
                '</DL>' | Out-File -FilePath $htmlOut1 -Append -Force -Encoding utf8
                Write-Host "DONE!!, Chrome Bookmars are copied to locations:---------------------------------
1. \\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\ChromeBookmark\ChromeBookmarks.html
2. \\$newComputer\C$\Temp\ChromeBookmarks.html.
-------------------------------------------------------------------------------------------------------------" -ForegroundColor White -BackgroundColor Green    
            }
            else{
                Write-Host "No Chrome Bookmarks on the Computer" -ForegroundColor White -BackgroundColor Red
            }
            
        }   
        else{
            Write-Host "Format not match" -ForegroundColor White -BackgroundColor Red
        }
    }
    else{
        Write-Host "Computer is offline" -ForegroundColor White -BackgroundColor Red
    }
    
}

function QuickAccess {
    New-Item "\\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\QuickAccess" -ItemType Directory -Force | Out-Null
    Copy-Item -Path "\\$oldComputer\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\f01b4d95cf55d32a.automaticDestinations-ms" -Destination "\\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\QuickAccess"  
    Copy-Item -Path "\\$oldComputer\C$\Users\$username\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations\f01b4d95cf55d32a.automaticDestinations-ms" -Destination "\\$newComputer\C$\Temp\QuickAccess\"
    Write-Host "QuickAccess are copied to locations:
1. \\$oldComputer\C$\Users\$username\OneDrive - Cox Architecture Pty Ltd\QuickAccess
2. \\$newComputer\C$\Temp\QuickAccess\" -ForegroundColor White -BackgroundColor Yellow
}


Bookmarks
QuickAccess

