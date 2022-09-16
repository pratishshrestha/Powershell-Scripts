$foldername = Read-Host "What is the folder name?"

$pathtosearch = Read-Host "Path to search the folder"

dir -Path $pathtosearch -Filter $foldername -Recurse | %{$_.FullName}

Read-Host "These are the folders. Press Enter to exit..."
#dir -Path \\melsrv01\Projects\~2014 -Filter "314043.01_Kavanagh-Park-Stage 01" -Recurse | %{$_.FullName}