# Install .NET 3.5 (incl 2.0) 
Install-WindowsFeature -Name "NET-Framework-Core" -Source "D:\Sources\SxS" 
 
# Remote into Server/Client 
enter-pssession *serverName* 
 
# Query Installed Server Roles & Features: 
Get-WindowsFeature | Where-Object {($_.InstallState -eq "Installed") -and ($_.FeatureType -eq "Role")} | Select-Object Name, InstallState, FeatureType
 
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