function Computer_Range{
    param (
        [string]$first,
        [string]$last
        )
    [CmdletBinding()]
    $result = @()
    if(($first.Substring(0,7) -eq $last.Substring(0,7)) -and ($first.Substring(7,3), $last.Substring(7,3) -match '\d\d\d')){
        $from = [int]$first.Substring(($first.Length) - 3)               ## Getting the last 3 digits of the user input and storing it to $from
        $last = [int]$last.Substring(($last.Length) - 3)                 ## Getting the last 3 digits of the user input and storing it to $last
        for ($i = $from; $i -le $last; $i+=1){
            $f = '{0:d3}' -f $i                                          ## Adding preceding 0's if one or two digit number, for eg. 1 is 001, 12 is 012   
            $result += @($first.Substring(0,7) + $f)                     ## Getting all the computers between first and last computer name on a result array
        }
        return $result 
    }
    else{
        [System.Windows.MessageBox]::Show("ERROR format doesn't match, correct format two numbers: mel-ws-XXX, mel-ws-XXX or mel-tb-XXX, mel-tb-XXX, 
        where XXX must be three digits, also you can't leave the field of first and last machine name empty")
    }
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

#This creates the form and sets its size and position
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "ADD APPS TO COMPUTER"
$objForm.Size = New-Object System.Drawing.Size(400,500) 
$objForm.StartPosition = "CenterScreen"

#This creates a label for the TextBox1
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(90,20) 
$objLabel1.Size = New-Object System.Drawing.Size(310,20) 
$objLabel1.Text = "Enter the Computer Range"
$objForm.Controls.Add($objLabel1) 

#This creates a label for the TextBox1
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(10,50) 
$objLabel1.Size = New-Object System.Drawing.Size(90,20) 
$objLabel1.Text = "First Computer:"
$objForm.Controls.Add($objLabel1) 

#This creates a label for the TextBox1
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(10,80) 
$objLabel1.Size = New-Object System.Drawing.Size(90,20) 
$objLabel1.Text = "Last Computer:"
$objForm.Controls.Add($objLabel1) 

#This creates the TextBox1
$objTextBox1 = New-Object System.Windows.Forms.TextBox 
$objTextBox1.Location = New-Object System.Drawing.Size(120,48) 
$objTextBox1.Size = New-Object System.Drawing.Size(200,120)
$objTextBox1.TabIndex = 0 
$objForm.Controls.Add($objTextBox1)

#This creates the TextBox1
$objTextBox2 = New-Object System.Windows.Forms.TextBox 
$objTextBox2.Location = New-Object System.Drawing.Size(120,80) 
$objTextBox2.Size = New-Object System.Drawing.Size(200,120)
$objTextBox2.TabIndex = 0 
$objForm.Controls.Add($objTextBox2)

#This creates a checkbox called App_CC2021
$App_CC2021 = New-Object System.Windows.Forms.Checkbox 
$App_CC2021.Location = New-Object System.Drawing.Size(10,130) 
$App_CC2021.Size = New-Object System.Drawing.Size(130,20)
$App_CC2021.Text = "App_CC2021"
$App_CC2021.TabIndex = 1
$objForm.Controls.Add($App_CC2021)

#This creates a checkbox called App_Acad2021
$App_Acad2021 = New-Object System.Windows.Forms.Checkbox 
$App_Acad2021.Location = New-Object System.Drawing.Size(10,160) 
$App_Acad2021.Size = New-Object System.Drawing.Size(130,20)
$App_Acad2021.Text = "App_Acad2021"
$App_Acad2021.TabIndex = 2
$objForm.Controls.Add($App_Acad2021)

#This creates a checkbox called App_OneDrive
$App_OneDrive = New-Object System.Windows.Forms.Checkbox 
$App_OneDrive.Location = New-Object System.Drawing.Size(10,190) 
$App_OneDrive.Size = New-Object System.Drawing.Size(130,20)
$App_OneDrive.Text = "App_OneDrive"
$App_OneDrive.TabIndex = 3
$objForm.Controls.Add($App_OneDrive)

#This creates a checkbox called App_Revit2020
$App_Revit2020 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2020.Location = New-Object System.Drawing.Size(10,220) 
$App_Revit2020.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2020.Text = "App_Revit2020"
$App_Revit2020.TabIndex = 4
$objForm.Controls.Add($App_Revit2020)

#This creates a checkbox called App_Revit2021
$App_Revit2021 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2021.Location = New-Object System.Drawing.Size(10,250) 
$App_Revit2021.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2021.Text = "App_Revit2021"
$App_Revit2021.TabIndex = 5
$objForm.Controls.Add($App_Revit2021)

#This creates a checkbox called App_Revit2022
$App_Revit2022 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2022.Location = New-Object System.Drawing.Size(10,280) 
$App_Revit2022.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2022.Text = "App_Revit2022"
$App_Revit2022.TabIndex = 6
$objForm.Controls.Add($App_Revit2022)

#This creates a checkbox called App_Lumion_v11.3
$App_Lumion = New-Object System.Windows.Forms.Checkbox 
$App_Lumion.Location = New-Object System.Drawing.Size(10,310) 
$App_Lumion.Size = New-Object System.Drawing.Size(130,20)
$App_Lumion.Text = "App_Lumion_v11.3"
$App_Lumion.TabIndex = 7
$objForm.Controls.Add($App_Lumion)

#This creates a checkbox called App_Lucid
$App_Lucid = New-Object System.Windows.Forms.Checkbox 
$App_Lucid.Location = New-Object System.Drawing.Size(10,340) 
$App_Lucid.Size = New-Object System.Drawing.Size(130,20)
$App_Lucid.Text = "App_Lucid"
$App_Lucid.TabIndex = 8
$objForm.Controls.Add($App_Lucid)

#This creates a checkbox called App_BlueBeam2020
$App_BlueBeam2020 = New-Object System.Windows.Forms.Checkbox 
$App_BlueBeam2020.Location = New-Object System.Drawing.Size(200,130) 
$App_BlueBeam2020.Size = New-Object System.Drawing.Size(130,20)
$App_BlueBeam2020.Text = "App_BlueBeam2020"
$App_BlueBeam2020.TabIndex = 9
$objForm.Controls.Add($App_BlueBeam2020)

#This creates a checkbox called App_SketchUp2021
$App_SketchUp2021 = New-Object System.Windows.Forms.Checkbox 
$App_SketchUp2021.Location = New-Object System.Drawing.Size(200,160) 
$App_SketchUp2021.Size = New-Object System.Drawing.Size(130,20)
$App_SketchUp2021.Text = "App_SketchUp2021"
$App_SketchUp2021.TabIndex = 10
$objForm.Controls.Add($App_SketchUp2021)

#This creates a checkbox called App_3dsMax2019
$App_3dsMax2019 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2019.Location = New-Object System.Drawing.Size(200,190) 
$App_3dsMax2019.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2019.Text = "App_3dsMax2019"
$App_3dsMax2019.TabIndex = 11
$objForm.Controls.Add($App_3dsMax2019)

#This creates a checkbox called App_3dsMax2020
$App_3dsMax2020 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2020.Location = New-Object System.Drawing.Size(200,220) 
$App_3dsMax2020.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2020.Text = "App_3dsMax2020"
$App_3dsMax2020.TabIndex = 12
$objForm.Controls.Add($App_3dsMax2020)

#This creates a checkbox called App_3dsMax2022
$App_3dsMax2022 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2022.Location = New-Object System.Drawing.Size(200,250) 
$App_3dsMax2022.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2022.Text = "App_3dsMax2022"
$App_3dsMax2022.TabIndex = 13
$objForm.Controls.Add($App_3dsMax2022)

#This creates a checkbox called App_Revit2019
$App_Revit2019 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2019.Location = New-Object System.Drawing.Size(200,280) 
$App_Revit2019.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2019.Text = "App_Revit2019"
$App_Revit2019.TabIndex = 13
$objForm.Controls.Add($App_Revit2019)

#This creates a checkbox called App_Revit2018
$App_Revit2018 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2018.Location = New-Object System.Drawing.Size(200,310) 
$App_Revit2018.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2018.Text = "App_Revit2018"
$App_Revit2018.TabIndex = 13
$objForm.Controls.Add($App_Revit2018)


#This creates the Ok button and sets the event
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(80,380)
$OKButton.Size = New-Object System.Drawing.Size(100,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$objform.AcceptButton = $OKButton
$OKButton.TabIndex = 14
$objForm.Controls.Add($OKButton)

#This creates the Cancel button and sets the event
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(200,380)
$CancelButton.Size = New-Object System.Drawing.Size(100,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$CancelButton.TabIndex = 15
$objForm.Controls.Add($CancelButton)
$objForm.Add_Shown({$objForm.Activate()})
$result = $objform.ShowDialog()


if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    # $compList = Computer_Range $objTextBox1.Text.Trim() $objTextBox2.Text.Trim()                #Getting Range of computer in array $compList
    # foreach($computer in $compList){
    if($objTextBox1.Text -and $objTextBox2.Text){                                           ##checking if the input text field is empty
        $compList = Computer_Range $objTextBox1.Text.Trim() $objTextBox2.Text.Trim()
        foreach($computer in $compList){
            $suffix = $computer.Substring(0,3)                                                  ##taking suffix eg, mel,syd,can,etc.
            $computer += "$"                                                                    ##storing the value of input text and adding $ at last
            $appList = @()                                              
            if ($App_CC2021.Checked -eq $True) {
                $appList += "App_CC2021-x64_$suffix"
            }
            if ($App_Acad2021.Checked -eq $True) {
                $appList += "App_Acad2021-x64_$suffix"
            }
            if ($App_OneDrive.Checked -eq $True) {
                $appList += "App_OneDrive-x64_$suffix"
            }
            if ($App_Revit2020.Checked -eq $True) {
                $appList += "App_Revit2020-x64_$suffix"
            }
            if ($App_Revit2021.Checked -eq $True) {
                $appList += "App_Revit2021-x64_$suffix"
            }
            if ($App_Revit2022.Checked -eq $True) {
                $appList += "App_Revit2022-x64_$suffix"
            }
            if ($App_Lumion.Checked -eq $True) {
                $appList += "App_Lumion-v11.3_$suffix"
            }
            if ($App_Lucid.Checked -eq $True) {
                $appList += "App_Lucid-x64_$suffix"
            }
            if ($App_BlueBeam2020.Checked -eq $True) {
                $appList += "App_BlueBeam2020-x64_$suffix"
            }
            if ($App_SketchUp2021.Checked -eq $True) {
                $appList += "App_SketchUp2021-x64_$suffix"
            }
            if ($App_3dsMax2019.Checked -eq $True) {
                $appList += "App_3dsMax2019-x64_$suffix"
            }
            if ($App_3dsMax2020.Checked -eq $True) {
                $appList += "App_3dsMax2020-x64_$suffix"
            }
            if ($App_3dsMax2022.Checked -eq $True) {
                $appList += "App_3dsMax2022-x64_$suffix"
            }
            try {
                foreach ($app in $appList){
                    Add-ADGroupMember -Identity $app -Members $computer
                }
            }
            catch {
                [System.Windows.MessageBox]::Show($_.exception.message,"Error",[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Error)
            }
        
        }
        [System.Windows.MessageBox]::Show("Default apps on $compList has been added.")   
    }
    else {
        [System.Windows.MessageBox]::Show("Program Abort due to empty field")
    }          
}






