## Set up ADDS ##
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSForest

# Verify DNS Server Role is installed
Get-WindowsFeature -Name 'DNS'

# Create Domain Admin Account
New-ADUser -Name "Rob Casey" -GivenName Rob -Surname Casey -SamAccountName rcasey -UserPrincipalName rcasey@caseylab.local -PasswordNeverExpires $true -AccountPassword (Read-Host -AsSecureString "AccountPassword") -PassThru | Enable-ADAccount

# Add user to Domain Admins to manage DC remotely:
Add-ADGroupMember -Identity "Domain Admins" -Members rcasey

# Confirm user was added to Security Group(s)
Get-ADGroupMember -Identity "Domain Admins" -Recursive

## Add a 2nd Domain Controller
# set network settings in sconfig or GUI, primary DNS must be set to DC!

$HashArguments = @{
    Credential = (Get-Credential "caseylab\rcasey")
    DomainName = "caseylab.local"
    InstallDns = $true
}
Install-ADDSDomainController @HashArguments

## DHCP ##
# Install Role, Security Groups, & Authorize DHCP Server
Install-WindowsFeature -Name DHCP -IncludeManagementTools
netsh dhcp add securitygroups
Restart-Service dhcpserver
Add-DhcpServerInDC -DnsName DC01.caseylab.local -IPAddress 10.30.0.101
Get-DhcpServerInDC

# (optional)
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

# Server level DNS Dynamic Update:
Set-DhcpServerv4DnsSetting -ComputerName "DC01.caseylab.local" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True
$Credential = Get-Credential
Set-DhcpServerDnsCredential -Credential $Credential -ComputerName "DC03.caseylab.local"

# Configure initial Scope
Add-DhcpServerv4Scope -name "PVE" -StartRange 10.10.0.110 -EndRange 10.10.0.199 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -DnsDomain "caseylab.local" -Router 10.10.0.254 -DnsServer 10.30.0.101,10.20.0.102,10.10.0.103


## install RSAT tools on remote (management) PC (if they are not found in 'other Windows features')
Add-WindowsCapability -Online -Name "RSAT.ActiveDirectory.DS-LDS.Tools"
Add-WindowsCapability -Online -Name "RSAT.DNS.Server"
Add-WindowsCapability -Online -Name "RSAT.DHCP.Tools"
Add-WindowsCapability -Online -Name "RSAT.GroupPolicy.Management.Tools"
Add-WindowsCapability -Online -Name "RSAT.ServerManager.Tools"

# Renaming a Domain Controller properly: 
netdom computername WIN-PAUQ93AOHVB.caseylab.local /add:dc01.caseylab.local
netdom computername WIN-PAUQ93AOHVB.caseylab.local /makeprimary:dc01.caseylab.local
shutdown /r /f /t 0
