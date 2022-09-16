# Makes sure the downloaded bios is loaded on c$, and model name matches.
# Change the C:\Temp\Latitude_5420_**** version on Line 10 from what downloaded from internet


Get-Content C:\Temp\laptop.txt | ForEach-Object{
    $machine = $_
    try{
        Invoke-Command -cn $machine -ScriptBlock {
            Suspend-BitLocker -MountPoint "C:" -RebootCount 1                 
            cmd /c 'C:\Temp\Latitude_7X20_1.18.0.exe /noPause /s /f /l=C:\Temp\BiOS.log'
        }
        Write-Host "$machine has been loaded with new BIOS. Remind user to restart `n"
    }
    catch{
        "$machine is offline"
    }
}

