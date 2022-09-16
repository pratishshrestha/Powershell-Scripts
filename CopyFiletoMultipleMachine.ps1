# GC C:\Temp\RemoteComputers.txt | %{Copy-Item -Path "C:\SomeFile.txt" -Destination "\\$_\C$\Destination" -Force}
# $Computers = Get-Content C:\Temp\RemoteComputers.txt
# ForEach ($Computer in $Computers) {
#     Copy-Item -Path "C:\SomeFile.txt" -Destination "\\$Computer\C$\Destination" -Force
# }

# GC C:\Temp\5420.txt | %{Copy-Item -Path "C:\Temp\Latitude_5420_1.18.2.exe" -Destination "\\$_\C$\Temp\" -Force}

GC C:\Temp\laptop.txt | %{
    $machine = $_
    try{
        Copy-Item -Path "\\melsrv01\Temp\Rochus.Li\Firmwares\Latitude_5420_1.20.0.exe" -Destination "\\$_\C$\Temp\" -Force
        Write-Host "Copied the item to $machine"
    }
    catch{
        "$machine is offline"
    }
}