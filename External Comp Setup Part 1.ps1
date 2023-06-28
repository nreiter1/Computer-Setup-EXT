#******External Computers Only!!! DO NOT RUN ON DOMAIN COMPUTERS!!!!!******

echo "This script is located on a flash drive."
echo "Make sure the flash drive is set to F: before proceeding forward!"

Read-Host -Prompt "Press any key to continue"

#Creates Anyone User

$password = ConvertTo-SecureString "Anyone" -AsPlainText -Force

New-LocalUser "Anyone" -Password $Password -PasswordNeverExpires
Add-LocalGroupMember -Name "Users" -Member "Anyone"

#Set Timezone to Central Time

Set-TimeZone -Name 'Central Standard Time'

#Enable System Restore on C:\ at 5%

Enable-ComputerRestore -Drive "C:\"
vssadmin resize shadowstorage /on=C: /for=C: /maxsize=5%

#Disable Fast Startup

powercfg.exe -h off #Disables both hibernate and fast startup options.

#Turn On Microsoft Updates for Other Microsoft Products

(New-Object -com "Microsoft.Update.ServiceManager").AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")

#WOL:

cd F:\Files\Scripts\ComputerSetup\Applications
.\WOL.exe

#Makes files and temp directory

cd C:\
mkdir Files, Temp

#OEM Microsoft Office Removal: Requires Restarting PC
$oemMicrosoftOffice = "A"
$oemMicrosoftOfficeInstallOffice = 1
while($oemMicrosoftOfficeInstallOffice -eq 1)
{
    $oemMicrosoftOffice = Read-Host -Prompt "Is this Operating System the original one that came with this computer?`n[Y]: Yes,[N]: No: "
    if($oemMicrosoftOffice -eq "Y")
    {
        cd 'F:\Files\Scripts\ComputerSetup\Applications\Office 2021 LTSC Std and Pro Plus Offline'
        Write-Output "See Microsoft Removal Application for removing OEM Office"
        .\o15-ctrremove.diagcab
        Read-Host -Prompt "When finished a reboot is required after naming PC, press any key to continue....."
        $oemMicrosoftOfficeInstallOffice = 0
    }
    elseif($oemMicrosoftOffice -eq "N")
    {
        Write-Output "OEM Office installations were NOT adjusted!"
        $oemMicrosoftOfficeInstallOffice = 0
    }
    else{Write-Output "Response is incorrect! Please try again!"}
}
#Rename Computer
$renameComputerWhile = 1

while($renameComputerWhile -eq 1)
{
    $computerName = Read-Host -Prompt "What is the name(service tag) for this pc?"
    $renameComputerTrue = Read-Host -Prompt "This PC will be named $computerName upon reboot. Are you sure?`n[Y]: Yes,[N]: No: "
    if($renameComputerTrue -eq "Y")
    {
        Rename-Computer -NewName $computerName
        $renameComputerWhile = 0
    }
    elseif($renameComputerTrue -ne "N")
    {
        Write-Host "Incorrect Response! Please Try Again!"
    }
}

Read-Host -Prompt "Finished!`nPress any key to exit and restart....."
Restart-Computer
