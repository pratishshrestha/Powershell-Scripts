<#
.SYNOPSIS
 

.DESCRIPTION
Range of computers between two inputs provided by users

.EXAMPLE
Instance, one input MEL-RW-001
second input MEL-RW-003
Result: MEL-RW-001, MEL-RW-002, MEL-RW-003

.NOTES
This is to assume that the second input of the computer is of 4 digits, not longer than that eg MEL-RW-1000 (1000 is 4 digits)
#>
function QueryfromRange {
	[CmdletBinding()]
    $result = @()       
    $first = Read-Host "What is the first machine name?"
    $last = Read-Host "What is the last machine name?"

    ## Checking First and Last seven characters if they match, if not disregard the program

    if ($first.Substring(0,7) -eq $last.Substring(0,7)) {
        ## Getting the last 3/4 digits of the firstmachine in the range

        $digitFirst = $first.Substring(7,($first.Length-7))     

        ## Getting the last either 3/4 digits of the lastmachine in the range

        $digitLast = $last.Substring(7,($last.Length-7))  

        Write-Host $digitFirst $digitLast

        if($digitLast.Length -eq 4){
            ## If the last machine name is of 4 digits, run first from firstmachine name to 999
            for ($i = [int]$digitFirst; $i -le 999 ; $i++){
                ## Adding preceding 0's if one or two digit number, for eg. 1 is 001, 12 is 012
                $f = '{0:d3}' -f $i
                $result += @($first.Substring(0,7) + $f)
            }
            ## Running from 4 digits to lastcomputer input and storing in result array
            for ($j = 1000; $j -le [int]$digitLast; $j++){
                ## converting integer $j to string to append eg. mel-ws-100
                $f = [string]$j
                $result += @($first.Substring(0,7) + $f)
            }
        }
        else{
            for ($i = [int]$digitFirst; $i -le [int]$digitLast; $i++){
                $f = '{0:d3}' -f $i
                $result += @($first.Substring(0,7) + $f)
            }
        }
        Write-Host $result
    }
    else{
        Write-Host "Format Error"
    }
}

QueryfromRange