function NameofFolder {
    $foldername = Read-Host "What is the name of the folder?"
    $year = '~' + '20' + $foldername.Substring(1,2)
    return $foldername, $year
}

function execution {
    $foldername, $year = NameofFolder
    if (Test-Path -Path \\melsrv01\Projects\$year\$foldername){
        Read-Host "Folder already exist, program exiting...."
    }
    else{
        Copy-Item -Path \\melsrv01\Reference\QA\ProjFolder -Destination \\melsrv01\Projects\$year\$foldername -Recurse
        Read-Host "Project Folder has been copied to \\melsrv01\Projects\$year\$foldername. Please Enter to exit."
    }
}

execution