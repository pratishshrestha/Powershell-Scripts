$scriptblock = {
    $scheduledTime = New-ScheduledTaskTrigger -At "08/16/2022 9:33:00 AM" -Once
    $scheduledAction = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument 'New-Item C:\Temp\Test2 -ItemType Directory -Force'
    Register-ScheduledTask -Force -TaskName "test" -Trigger $scheduledTime -Action $scheduledAction -User 'SYSTEM'
}

$result = @(Get-Content C:\Temp\laptop.txt)
$result | ForEach-Object{
    $compName = $_
    Invoke-Command -ComputerName $compName -ScriptBlock $scriptblock
}

