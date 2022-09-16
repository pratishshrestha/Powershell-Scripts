$result = @()
$first = Read-Host "What is the first machine name?"
$last = Read-Host "What is the last machine name?"

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
            try {
                Write-Host "##############################   $resultnumber      ###############################"
                Invoke-Command -ComputerName $_ -ScriptBlock {shutdown /s} -ErrorAction Stop
                Write-Host "`n"
            }
            catch {
                Write-Host "$resultnumber is offline"
                Write-Host "`n"
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
