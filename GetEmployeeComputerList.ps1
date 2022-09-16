$time = Get-Date -Format "dddd MM/dd/yyyy HH:mm"
[int]$selection = Read-Host "--------------------------------------------------------------------------
Which studio would you like to perform this action? Please input number.
1. Sydney
2. Melbourne
3. Canberra
4. Brisbane
5. Adelaide
6. Perth
"

function Get-Numberlist {
    Param ([array]$number)
    Write-Host "-----------------------------------------------------------------------------------"
    $list = for($i = 1; $i -le $number.count; $i++) {
        "$($i). $($number[$i-1])"
    } 
    return $list
}

function Get-Employee {
    $employees = Get-ADUser -Filter * -SearchBase "OU=Employees,OU=Users,OU=$location,OU=COX.V2,DC=coxgroup,DC=internal"
    $employees = $employees.name | Sort-Object
    $list = Get-Numberlist -number $employees
    $count = $employees.count
    Write-Host ($list -join "`n")
    Write-Host "------------------------------------------------------------------------------------------------------------`n"
    Write-Host "As of $time, there are $count employees, including people in Parental Leave.`n"
    Write-Host "------------------------------------------------------------------------------------------------------------"
}

function Get-Device {
    $laptop =  Get-ADComputer -Filter * -Properties Name, Description -SearchBase "OU=Notebooks,OU=Computers,OU=$location,OU=COX.V2,DC=coxgroup,DC=internal" | Select-Object Name, Description
    $workstation = Get-ADComputer -Filter * -Properties Name, Description -SearchBase "OU=Workstations,OU=Computers,OU=$location,OU=COX.V2,DC=coxgroup,DC=internal" | Select-Object Name, Description
    $laptopList = $laptop.name
    $laptopCount = $laptopList.count
    $workstationList = $workstation.name
    $workstationCount = $workstationList.count
    Write-Host "------------------------------------------------------------------------------------------------------------`n"
    Write-Host "As of $time, there are $laptopCount active laptops/tablets and $workstationCount active workstations.`n"
    Write-Host "------------------------------------------------------------------------------------------------------------"

}


switch ($selection) {
    1 { $location = "Sydney"; Get-Employee; Get-Device; Break }
    2 { $location = "Melbourne"; Get-Employee; Get-Device; Break }
    3 { $location = "Canberra"; Get-Employee; Get-Device; Break }
    4 { $location = "Brisbane"; Get-Employee; Get-Device; Break }
    5 { $location = "Adelaide"; Get-Employee; Get-Device; Break }
    6 { $location = "Perth"; Get-Employee; Get-Device; Break }
    Default {Write-Host "Incorrect Studio Code, program will exit"}
}
