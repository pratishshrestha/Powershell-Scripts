Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

#This creates the form and sets its size and position
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "ADD APPLICATIONS TO THE COMPUTER"
$objForm.Size = New-Object System.Drawing.Size(360,330) 
$objForm.StartPosition = "CenterScreen"

#This creates a label for the TextBox1
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(10,20) 
$objLabel1.Size = New-Object System.Drawing.Size(310,20) 
$objLabel1.Text = "Enter the Computer Name:"
$objForm.Controls.Add($objLabel1) 

#This creates the TextBox1
$objTextBox1 = New-Object System.Windows.Forms.TextBox 
$objTextBox1.Location = New-Object System.Drawing.Size(10,40) 
$objTextBox1.Size = New-Object System.Drawing.Size(310,20)
$objTextBox1.TabIndex = 0 
$objForm.Controls.Add($objTextBox1)

#This creates a checkbox called App_CC2021
$App_CC2021 = New-Object System.Windows.Forms.Checkbox 
$App_CC2021.Location = New-Object System.Drawing.Size(10,80) 
$App_CC2021.Size = New-Object System.Drawing.Size(130,20)
$App_CC2021.Text = "App_CC2021"
$App_CC2021.TabIndex = 1
$objForm.Controls.Add($App_CC2021)

#This creates a checkbox called App_Acad2021
$App_Acad2021 = New-Object System.Windows.Forms.Checkbox 
$App_Acad2021.Location = New-Object System.Drawing.Size(10,100) 
$App_Acad2021.Size = New-Object System.Drawing.Size(130,20)
$App_Acad2021.Text = "App_Acad2021"
$App_Acad2021.TabIndex = 2
$objForm.Controls.Add($App_Acad2021)

#This creates a checkbox called App_OneDrive
$App_OneDrive = New-Object System.Windows.Forms.Checkbox 
$App_OneDrive.Location = New-Object System.Drawing.Size(10,120) 
$App_OneDrive.Size = New-Object System.Drawing.Size(130,20)
$App_OneDrive.Text = "App_OneDrive"
$App_OneDrive.TabIndex = 3
$objForm.Controls.Add($App_OneDrive)

#This creates a checkbox called App_Revit2020
$App_Revit2020 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2020.Location = New-Object System.Drawing.Size(10,140) 
$App_Revit2020.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2020.Text = "App_Revit2020"
$App_Revit2020.TabIndex = 4
$objForm.Controls.Add($App_Revit2020)

#This creates a checkbox called App_Revit2021
$App_Revit2021 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2021.Location = New-Object System.Drawing.Size(10,160) 
$App_Revit2021.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2021.Text = "App_Revit2021"
$App_Revit2021.TabIndex = 5
$objForm.Controls.Add($App_Revit2021)

#This creates a checkbox called App_Revit2022
$App_Revit2022 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2022.Location = New-Object System.Drawing.Size(10,180) 
$App_Revit2022.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2022.Text = "App_Revit2022"
$App_Revit2022.TabIndex = 6
$objForm.Controls.Add($App_Revit2022)

#This creates a checkbox called App_Lumion_v11.3
$App_Lumion = New-Object System.Windows.Forms.Checkbox 
$App_Lumion.Location = New-Object System.Drawing.Size(10,200) 
$App_Lumion.Size = New-Object System.Drawing.Size(130,20)
$App_Lumion.Text = "App_Lumion_v11.3"
$App_Lumion.TabIndex = 7
$objForm.Controls.Add($App_Lumion)

#This creates a checkbox called App_Lucid
$App_Lucid = New-Object System.Windows.Forms.Checkbox 
$App_Lucid.Location = New-Object System.Drawing.Size(10,200) 
$App_Lucid.Size = New-Object System.Drawing.Size(130,20)
$App_Lucid.Text = "App_Lucid"
$App_Lucid.TabIndex = 8
$objForm.Controls.Add($App_Lucid)

#This creates a checkbox called App_BlueBeam2020
$App_BlueBeam2020 = New-Object System.Windows.Forms.Checkbox 
$App_BlueBeam2020.Location = New-Object System.Drawing.Size(200,80) 
$App_BlueBeam2020.Size = New-Object System.Drawing.Size(130,20)
$App_BlueBeam2020.Text = "App_BlueBeam2020"
$App_BlueBeam2020.TabIndex = 9
$objForm.Controls.Add($App_BlueBeam2020)

#This creates a checkbox called App_SketchUp2021
$App_SketchUp2021 = New-Object System.Windows.Forms.Checkbox 
$App_SketchUp2021.Location = New-Object System.Drawing.Size(200,100) 
$App_SketchUp2021.Size = New-Object System.Drawing.Size(130,20)
$App_SketchUp2021.Text = "App_SketchUp2021"
$App_SketchUp2021.TabIndex = 10
$objForm.Controls.Add($App_SketchUp2021)

#This creates a checkbox called App_3dsMax2019
$App_3dsMax2019 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2019.Location = New-Object System.Drawing.Size(200,120) 
$App_3dsMax2019.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2019.Text = "App_3dsMax2019"
$App_3dsMax2019.TabIndex = 11
$objForm.Controls.Add($App_3dsMax2019)

#This creates a checkbox called App_3dsMax2020
$App_3dsMax2020 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2020.Location = New-Object System.Drawing.Size(200,140) 
$App_3dsMax2020.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2020.Text = "App_3dsMax2020"
$App_3dsMax2020.TabIndex = 12
$objForm.Controls.Add($App_3dsMax2020)

#This creates a checkbox called App_3dsMax2022
$App_3dsMax2022 = New-Object System.Windows.Forms.Checkbox 
$App_3dsMax2022.Location = New-Object System.Drawing.Size(200,160) 
$App_3dsMax2022.Size = New-Object System.Drawing.Size(130,20)
$App_3dsMax2022.Text = "App_3dsMax2022"
$App_3dsMax2022.TabIndex = 13
$objForm.Controls.Add($App_3dsMax2022)

#This creates a checkbox called App_Revit2019
$App_Revit2019 = New-Object System.Windows.Forms.Checkbox 
$App_Revit2019.Location = New-Object System.Drawing.Size(200,180) 
$App_Revit2019.Size = New-Object System.Drawing.Size(130,20)
$App_Revit2019.Text = "App_Revit2019"
$App_Revit2019.TabIndex = 13
$objForm.Controls.Add($App_Revit2019)


#This creates the Ok button and sets the event
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(80,250)
$OKButton.Size = New-Object System.Drawing.Size(100,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$objform.AcceptButton = $OKButton
$OKButton.TabIndex = 14
$objForm.Controls.Add($OKButton)

#This creates the Cancel button and sets the event
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(200,250)
$CancelButton.Size = New-Object System.Drawing.Size(100,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$CancelButton.TabIndex = 15
$objForm.Controls.Add($CancelButton)
$objForm.Add_Shown({$objForm.Activate()})
$result = $objform.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    if($objTextBox1.Text){                                  ##checking if the input text field is empty
        $compName=$objTextBox1.Text.Trim() + "$"            ##storing the value of input text and adding $ at last
        $suffix = $compName.Substring(0,3)                  ##taking suffix eg, mel,syd,can,etc.
        $appList = @()
        if ($App_CC2021.Checked -eq $True) {
            $appList += "App_CC2022-x64_$suffix"
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
        if ($App_Revit2019.Checked -eq $True) {
            $appList += "App_Revit2019-x64_$suffix"
        }
        try {
            foreach ($app in $appList){
                Add-ADGroupMember -Identity $app -Members $compName
            }
            [System.Windows.MessageBox]::Show("Default apps on $compName has been added.")
        }
        catch {
            [System.Windows.MessageBox]::Show($_.exception.message,"Error",[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Error)
        }
    
    }   
    else{
        [System.Windows.MessageBox]::Show("Program Abort due to empty field")
    }   
}
