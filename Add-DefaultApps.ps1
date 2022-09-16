Add-Type -AssemblyName PresentationFramework
 
[xml]$XAMLWindow = '
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Height="Auto"
    SizeToContent="WidthAndHeight"
    Title="Add-Apps">
    <ScrollViewer Padding="10,10,10,0" ScrollViewer.VerticalScrollBarVisibility="Disabled">
        <StackPanel>
            <StackPanel Orientation="Horizontal">
                <Label Margin="10,10,0,10">ComputerName:</Label>
                <TextBox Name="Input" Margin="10" Width="250px"></TextBox>
            </StackPanel>
            <DockPanel>
                <Button Name="ButtonGetService" Content="Add-Apps" Margin="10" Width="150px" IsEnabled="false"/>
                <Button Name="ButtonClose" Content="Close" HorizontalAlignment="Right" Margin="10" Width="50px"/>
            </DockPanel>
        </StackPanel> 
    </ScrollViewer >
</Window>
'

# Create the Window Object
$Reader=(New-Object System.Xml.XmlNodeReader $XAMLWindow)
$Window=[Windows.Markup.XamlReader]::Load( $Reader )

# TextChanged Event Handler for Input 
$TextboxInput = $Window.FindName("Input")
$TextboxInput.add_TextChanged.Invoke({
    $ComputerName = $TextboxInput.Text
    $ButtonGetService.IsEnabled = $ComputerName -ne ''
})

# Click Event Handler for ButtonClose
$ButtonClose = $Window.FindName("ButtonClose")
$ButtonClose.add_Click.Invoke({
    $Window.Close();
})

# Click Event Handler for ButtonGetService
$ButtonGetService = $Window.FindName("ButtonGetService")
$ButtonGetService.add_Click.Invoke({
    $ComputerName = $TextboxInput.Text.Trim() + "$"
    $suffix = $ComputerName.Substring(0,3)
    try{

        ## Groups variable are default apps which will get added when providing computer name
        $groups = "App_CC2022-x64_$suffix", "App_Acad2021-x64_$suffix", "App_OneDrive-x64_$suffix", "App_Revit2020-x64_$suffix", "App_Revit2021-x64_$suffix", "App_Revit2022-x64_$suffix"
        foreach ($group in $groups){
            Add-ADGroupMember -Identity $group -Members $ComputerName
        }
        [System.Windows.MessageBox]::Show("Default apps on $ComputerName has been added.")
    }catch{
        [System.Windows.MessageBox]::Show($_.exception.message,"Error",[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Error)
    }
})

# Open the Window
$Window.ShowDialog() | Out-Null