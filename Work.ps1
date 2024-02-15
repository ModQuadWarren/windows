# Install .NET 3.5 (incl 2.0) 
Install-WindowsFeature -Name "NET-Framework-Core" -Source "D:\Sources\SxS" 
 
# Remote into Server/Client 
enter-pssession *serverName* 
 
# Query Installed Server Roles & Features: 
Get-WindowsFeature | Where-Object {($_.InstallState -eq "Installed") -and ($_.FeatureType -eq "Role")} | Select-Object Name, InstallState, FeatureType

# PSWindowsUpdate
Install-Module -Name PSWindowsUpdate -Force -AllowClobber
Import-Module PSWindowsUpdate
Get-WindowsUpdate | Install-WindowsUpdate -AcceptAll -AutoReboot
invoke-WUJob -Script { Install-WindowsUpdate -AcceptAll -SendReport -IgnoreReboot } -Confirm:$false -verbose -RunNow

# Query pending Windows updates: 
$searchresult.Updates.Count
 
# Find Serial Number: 
Get-CimInstance Win32_BIOS 
 
# Users not logged on for 90 Days > Export to csv: 
get-aduser -filter 'enabled -eq $true' -Properties lastlogondate | Where-object {$_.lastlogondate -lt (get-date).AddDays(-90)} | Export-csv C:\temp\users.csv -NoTypeInformation -Force -Delimiter ";" 
 
# Computer Accounts not logged on in 90 days > export to csv: 
$90DaysAgo = (Get-Date).AddDays(-90)
Get-ADComputer -Filter {LastLogonDate -lt $90DaysAgo -or LastLogonDate -eq $null} -Properties LastLogonDate | Select-Object Name, LastLogonDate

# Find Currently Logged-in user: 
Get-WMIObject -class Win32_ComputerSystem | Select-Object username

## Suspend-Resume Bitlocker: 
manage-bde -status
Suspend-BitLocker -MountPoint "C:"
Resume-BitLocker -MountPoint "C:"
 
# Manually add Bitlocker Recovery Key to AD: 
manage-bde -protectors -get c:
 
# Then take the Numerical Password ID and plug it in to the following command: 
manage-bde -protectors c: -adbackup -id '{<BACKUPID>}'

## HYPER-V ##
# Query Currently Running VMs (from host server): 
Get-VM | format-list VMname, VMID

# Cancel all local print jobs
Stop-Service -Name "Spooler" -Force
Remove-Item "%systemroot%\system32\spool\printers\*.shd" 
Remove-Item "%systemroot%\system32\spool\printers\*.spl" 
Start-Service -Name "Spooler"

# Remove local GP settings
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose 
Remove-Item -Path "$env:WinDir\System32\GroupPolicyUsers" -Force -Recurse
Remove-Item -Path "$env:WinDir\System32\GroupPolicy" -Force -Recurse

# Display open ports
netstat -aon | findstr /i listening

## Drive Maps ## 
# Query  
net use 
 
# Add 
net use s: \\tower\movies /persistent:Yes 
 
# Remove 
net use s: /delete 

## Local Users & Groups
# Get local users/groups
Get-LocalUser
Get-LocalGroup

# Get groups of a local user
net user rob

# create new local user
$Password = Read-Host -AsSecureString
New-LocalUser -Name rob -Description “Second Admin Account” -Password $Password

# check local admins
Get-LocalGroupMember Administrators

# remove users from local admin group
$members = "Admin02", "MicrosoftAccount\username@Outlook.com", "AzureAD\DavidChew@contoso.com", "CONTOSO\Domain Admins"
Remove-LocalGroupMember -Group "Administrators" -Member $members

# add LOCAL account/group to LOCAL administrators group
$members = "Admin02", "MicrosoftAccount\username@Outlook.com", "AzureAD\DavidChew@contoso.com", "CONTOSO\Domain Admins"
Add-LocalGroupMember -Group "Administrators" -Member $members

# add DOMAIN account/group to LOCAL administrators group
Add-LocalGroupMember -Group “Administrators” -Member “Contoso\rob”

# Disable local Admin User Account
Disable-LocalUser -Name "Administrator"

# send wake-on-LAN packet
$Mac = "B4:2E:99:E0:16:07"
$MacByteArray = $Mac -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
[Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)
$UdpClient = New-Object System.Net.Sockets.UdpClient
$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
$UdpClient.Send($MagicPacket,$MagicPacket.Length)
$UdpClient.Close()