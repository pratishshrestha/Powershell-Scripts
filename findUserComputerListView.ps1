Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

#This creates the form and sets its size and position
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "       Computer Description"
$objForm.Size = New-Object System.Drawing.Size(500,450) 
$objForm.StartPosition = "CenterScreen"
$objForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon('C:\Users\_m-pshrestha\Documents\Personal\Test\Cox_logo.ico')


#This creates a label for the TextBox1
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(90,20) 
$objLabel1.Size = New-Object System.Drawing.Size(250,20) 
$objLabel1.Text = "Enter the User Name"
$objLabel1.Font = 'Lucida Console, 15pt'
# $objLabel1.Font = 'Lucida Console, 10pt, style=Bold, Italic'
$objForm.Controls.Add($objLabel1) 

#This creates the TextBox1
$objTextBox1 = New-Object System.Windows.Forms.TextBox 
$objTextBox1.AutoSize = $false
$objTextBox1.Location = New-Object System.Drawing.Size(110,48) 
$objTextBox1.Size = New-Object System.Drawing.Size(200,25)
$objTextBox1.Font = 'Lucida Console, 12pt'
# $objTextBox1.TabIndex = 0 
$objForm.Controls.Add($objTextBox1)

#This creates the Ok button and sets the event
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.AutoSize = $false
$OKButton.Font = 'Lucida Console, 15pt'
$OKButton.Location = New-Object System.Drawing.Size(350,22)
$OKButton.Size = New-Object System.Drawing.Size(100,50)
$OKButton.Text = "OK"
# $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
# $objform.AcceptButton = $OKButton
# $OKButton.TabIndex = 14
$objForm.Controls.Add($OKButton)

#This creates the TextBox1
$objTextBox2 = New-Object System.Windows.Forms.TextBox 
$objTextBox2.AutoSize = $false
$objTextBox2.ReadOnly = $true
$objTextBox2.Multiline = $true
$objTextBox2.Scrollbars = "Vertical"
$objTextBox2.Location = New-Object System.Drawing.Size(20,100) 
$objTextBox2.Size = New-Object System.Drawing.Size(450,300)
$objTextBox2.Font = 'Lucida Console, 8pt'
$objTextBox2.WordWrap = $true
$objForm.Controls.Add($objTextBox2)

#onclick of OK Button
$OKButton.add_Click({
    $ComputerName = $objTextBox1.text.Trim()
    $ComputerName = -join ("*","$ComputerName","*")
    try{
        $display = Get-ADComputer -Filter {description -Like $ComputerName} -Properties description | Select-Object Name, Description
        $objTextBox2.Text = $display | Format-Table -AutoSize | Out-String
    }
    catch{
        [System.Windows.MessageBox]::Show($_.exception.message,"Error",[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Error)
    }
})

$objform.ShowDialog()







