#Microsoft Office Install
$officeInstallWhile = 1
$install2021Standard = "`nInstalling Office 2021 Standard"
$install2021ProfessionalPlus = "`nInstalling Office 2021 Professional Plus"

cd 'F:\ComputerSetup\Applications\Office 2021 LTSC Std and Pro Plus'

while($officeInstallWhile -eq 1)
{
   $officeInstall = Read-Host -Prompt "Which Office 2021 type do you want to install?`n[S]: Standard,[P]: Professional Plus [N]: None: " 
    if($officeInstall -eq "S") #21 Standard 64-Bit
    {
        Read-Host -Prompt "Refer to the Microsoft Office Remover Tool IF this OS came with this computer and you HAVEN'T done so.`nWhen done, press enter to install office"
        Write-Output $install2021Standard
        .\setup.exe /configure "F:\ComputerSetup\Applications\Office 2021 LTSC Std and Pro Plus\Office\Configuration-GC-SHI-Std-64.xml" #NOT INCLUDED IN GIT REPOSITORY FOR SECURITY REASONS
        $officeInstallWhile = 0
    }
    elseif($officeInstall -eq "P")#21 Pro Plus 64-Bit
    {
        Read-Host -Prompt "Refer to the Microsoft Remover Tool IF this OS came with this computer and you HAVEN'T done so.`nWhen done, press enter to install office"
        Write-Output $install2021ProfessionalPlus
        .\setup.exe /configure "F:\ComputerSetup\Applications\Office 2021 LTSC Std and Pro Plus\Office\Configuration-GC-SHI-ProPlus-64.xml" #NOT INCLUDED IN GIT REPOSITORY FOR SECURITY REASONS
        $officeInstallWhile = 0
    }
    elseif($officeInstall -eq "N") #No Office Installed
    { 
        "Office was NOT installed!"
        $officeInstallWhile = 0
    }
}

Read-Host -Prompt "Finished!`nPress any key to exit....."
