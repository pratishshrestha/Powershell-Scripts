$userInput = Read-Host "
------------------------------------------------------------------------------------

This script can be used to copy all members of one group and add them to another.
Useful for major app updates. For an example Adobe CC 2021 to Adobe CC 2022.

Which studio would you like to perform this action? Please input number.
1. Sydney
2. Melbourne
3. Canberra
4. Brisbane
5. Adelaide
6. Perth

------------------------------------------------------------------------------------
"

# Get a list of Applications on Melbourne OU
function Applications {
    Param ([string]$location)
    $applist = Get-ADGroup -Filter * -SearchBase "OU=Applications,OU=Groups,OU=$location,OU=COX.V2,DC=coxgroup,DC=internal" | Select-Object Name
    $applist = $applist.name | Sort-Object
    return $applist
}

#Making a list of applications in numerical order (not important but used for displaying data)
function Applist {
    Param ([array]$applist)
    Write-Host "-----------------------------------------------------------------------------------"
    $list = for($i = 1; $i -le $applist.count; $i++) {
        "$($i). $($applist[$i-1])"
    } 
    return $list
}

# Get a list of workstations from the Application group
function workstationList {
    Param ([string]$fromGroup)
    $computer = Get-ADGroupMember -identity $fromGroup | Select-Object SamAccountName
    $workstation = $computer.SamAccountName | Where-Object {$_ -imatch '(\bmel\b|\bsyd\b|\bcan\b|\bade\b|\bper\b|\bbri\b)-(\bws\b|\brw\b|\brn\b)-\d\d\d[$]$'} | Sort-Object
    return $workstation
}

# Get a list of laptops and tablets from the Application group
function notebookList {
    Param ([string]$fromGroup)
    $computer = Get-ADGroupMember -identity $fromGroup | Select-Object SamAccountName
    $laptop = $computer.SamAccountName | Where-Object {$_ -imatch '(\bmel\b|\bsyd\b|\bcan\b|\bade\b|\bper\b|\bbri\b)-(\bnb\b|\btb\b)-\d\d\d[$]$'} | Sort-Object
    return $laptop
}

function executeWorkstation {
    Param 
    (
        [Parameter(Mandatory=$true, Position=0)]
        [array] $workstation,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $newApp
    )
    # $workstation | ForEach-Object {Add-ADGroupMember -id $newApp -members $_}

    Write-Host $workstation
    Write-Host $newApp
}

function executeLaptop {
    Param 
    (
        [Parameter(Mandatory=$true, Position=0)]
        [array] $laptop,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $newApp
    )
    # $laptop | ForEach-Object {Add-ADGroupMember -id $newApp -members $_}

    Write-Host $laptop
    Write-Host $newApp
}

function executeCombined {
    Param 
    (
        [Parameter(Mandatory=$true, Position=0)]
        [array] $combined,
        [Parameter(Mandatory=$true, Position=1)]
        [string] $newApp
    )
    # $combined | ForEach-Object {Add-ADGroupMember -id $newApp -members $_}

    Write-Host $combined
    Write-Host $newApp
}
function Melbourne {
    $applist = Applications -location Melbourne
    # Writing ascending numbers in front of applications list
    $applistMel = Applist -applist $applist
    # $applistMel = for($i = 1; $i -le $applist.count; $i++) {
    #     "$($i). $($applist[$i-1])"
    # } 
    # Inject a new line between each element in the array
    Write-Host ($applistMel -join "`n")
    # Write-Host "--------------------------------------------------------------------"
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    Write-Host "-----------------------------------------------------------------------------"
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

function Sydney {
    $applist = Applications -location Sydney
    # Writing ascending numbers in front of applications list
    $applistSyd = Applist -applist $applist
    Write-Host ($applistSyd -join "`n")
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

function Canberra {
    $applist = Applications -location Canberra
    # Writing ascending numbers in front of applications list
    $applistCan = Applist -applist $applist
    Write-Host ($applistCan -join "`n")
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

function Brisbane {
    $applist = Applications -location Brisbane
    # Writing ascending numbers in front of applications list
    $applistBri = Applist -applist $applist
    Write-Host ($applistBri -join "`n")
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

function Adelaide {
    $applist = Applications -location Adelaide
    # Writing ascending numbers in front of applications list
    $applistAde = Applist -applist $applist
    Write-Host ($applistAde -join "`n")
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

function Perth {
    $applist = Applications -location Perth
    # Writing ascending numbers in front of applications list
    $applistPer = Applist -applist $applist
    Write-Host ($applistPer -join "`n")
    [int]$fromGroup = Read-Host "
    ------------------------------------------------------------------------------
    What is the application number that you would like to copy users FROM?  "
    [int]$toGroup = Read-Host "
    What is the application number that you would like to copy users TO?    "
    Write-Host "
    ------------------------------------------------------------------------------"

    $laptop = notebookList -fromGroup $applist[$fromGroup - 1]

    $workstation = workstationList -fromGroup $applist[$fromGroup - 1]

    $combined = @($laptop) + @($workstation)

    $x = $applist[$fromGroup - 1]
    $y = $applist[$toGroup - 1]
    $title    = "You are about to copy members from $x to $y"
    $question = 'Are you sure you want to proceed?'
    $choices  = '&Yes', '&No'

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 0)
    if ($decision -eq 0) {
        $choice = Read-Host " Do you want to prefer this operation on: (Please write number)
        1. Workstation
        2. Laptop
        3. All
        "
        switch($choice){
            1 {executeWorkstation -workstation $workstation -newApp $y; Break;}
            2 {executeLaptop -laptop $laptop -newApp $y; Break;}
            3 {executeCombined -combined $combined -newApp $y; Break;}
            Default {Write-Host "Incorrect Number, program will exit"}
        }

    } else {
        Write-Host 'Program Abort'
    }
}

switch ($userInput) {
    1 { Sydney; Break }
    2 { Melbourne; Break }
    3 { Canberra; Break }
    4 { Brisbane; Break }
    5 { Adelaide; Break }
    6 { Perth; Break }
    Default {Write-Host "Incorrect Studio Code, program will exit"}
}