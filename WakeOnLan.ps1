function Send-WOL

{
<#
  .SYNOPSIS 
    Send a WOL packet to a broadcast address
  .PARAMETER mac
   The MAC address of the device that need to wake up
  .PARAMETER ip
   The IP address where the WOL packet will be sent to
  .EXAMPLE
   Send-WOL -mac 00:11:22:33:44:55 -ip 192.168.2.100
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$True,Position=1)]
    [string]$mac,
    [string]$ip="255.255.255.255",
    [int]$port=9
)

$broadcast = [Net.IPAddress]::Parse($ip)

$mac=(($mac.replace(":","")).replace("-","")).replace(".","")

$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)}

$packet = (,[byte]255 * 6) + ($target * 16)

$UDPclient = new-Object System.Net.Sockets.UdpClient

$UDPclient.Connect($broadcast,$port)

[void]$UDPclient.Send($packet, 102)

}

Function Update-macList{

$servername = 'datsms11'
$databasename = 'CM_P01'
$query = "select v_R_System.Netbios_Name0,v_RA_System_MACAddresses.MAC_Addresses0 from v_R_System,v_RA_System_MACAddresses,v_RA_System_IPSubnets where v_R_System.Active0 =1and v_RA_System_MACAddresses.ResourceID=v_RA_System_IPSubnets.ResourceID and v_RA_System_IPSubnets.ResourceID=v_R_System.ResourceID and v_R_System.ResourceID=v_RA_System_MACAddresses.ResourceID"

$connectionString = "Server = $serverName; database= $DatabaseName ; Integrated Security= True;"

$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $connectionString
$sqlConnection.Open()

$command = New-Object System.Data.SQLClient.SQLCommand($query, $sqlConnection)

$macList = New-Object System.Data.DataTable
$SqlDataReader = $command.ExecuteReader()
$maclist.Load($SqlDataReader)

$sqlConnection.Close()

$maclist = $maclist | Select Netbios_name0, MAC_Addresses0 | Sort-Object Netbios_name0 -Unique

Return $macList
}
Write-Host "#######################################################################"
Write-Host "#######################################################################"
Write-Host "Please write down the correct machine range for the program to run well"
Write-Host "#######################################################################"
Write-Host "#######################################################################"

$macList = Update-macList
$result = @()
$first = (Read-Host "What is the first machine name?").ToUpper() ##
$last = (Read-Host "What is the last machine name?").ToUpper()   ## Changing the user input to uppercase

try {
  if(($first.Substring(0,7) -eq $last.Substring(0,7)) -and ($first.Substring(7,3), $last.Substring(7,3) -match '\d\d\d')){
    $from = [int]$first.Substring(($first.Length) - 3)               ## Getting the last 3 digits of the user input and storing it to $from
    $last = [int]$last.Substring(($last.Length) - 3)                 ## Getting the last 3 digits of the user input and storing it to $last
    for ($i = $from; $i -le $last; $i+=1){
        $f = '{0:d3}' -f $i                                          ## Adding preceding 0's if one or two digit number, for eg. 1 is 001, 12 is 012   
        $result += @($first.Substring(0,7) + $f)                     ## Getting all the computers between first and last computer name on a result array
    }
    $result | ForEach-Object {
      $resultnumber = $_
      $selectedComputer = $macList | Where-Object {$_.Netbios_Name0 -eq $resultnumber}
      if ($selectedComputer -eq $null){}                              ## if between the result array the computer in AD isn't present just ignore
      else{
        try{
            $x = Resolve-DnsName -name $selectedComputer.Netbios_Name0 -ErrorAction Stop         ##-erroraction stop = forcing non terminating errors to be terminating errors & assigned to x just so to not print in the console
            $computerip = (Resolve-DnsName -name $selectedComputer.Netbios_Name0 | Where-Object {$_.Type -eq 'A'}).IPAddress 
            $bAddress = $computerip -replace '[.](\d|\d\d|\d\d\d)$','.255'
            # # $senderIP = (Resolve-DnsName -name $env:COMPUTERNAME | Where-Object {$_.Type -eq 'A'}).IPAddress     
            Write-Host "Attempting to power on $($selectedComputer.Netbios_Name0) | $($selectedComputer.MAC_Addresses0) | $bAddress"    
            Send-WOL -mac $selectedComputer.MAC_Addresses0 -ip $bAddress
            Start-Sleep -s 2
        }
        catch { "$resultnumber has been turned off for very long time and WOL doesn't work on this"}
        }
    }
  }
  else{
    Write-Host "ERROR format doesn't match, correct format two numbers: mel-ws-XXX, mel-ws-XXX or mel-tb-XXX, mel-tb-XXX, where XXX must be three digits"
  }
}  

catch {
  {"ERROR because the prefix doesn't match, correct format: MEL-WS-XXX, XXX=3 digits are necessary"}
}


