## ENABLE PSREMOTING ON WINDOWS SERVER ##
# check current WSMan Trusted Hosts:
Get-Item WSMan:\localhost\Client\TrustedHosts

# add to TrustedHosts after enabling PSRemoting
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "dc01,dc02,mssql01,mstomcat"

# remove from TrustedHosts
Remove-Item WSMan:\localhost\Client\TrustedHosts -Value "dc01,dc02,mssql01,mstomcat"

# check current WSMan delegates:
(Get-Item WSMan:\localhost\Client\TrustedHosts).Value

# add delegate computer
Enable-WSManCredSSP -Role client -DelegateComputer dc01

# add cmdkey (local)
cmdkey /add:dc02 /user:dc02\Administrator /pass

# add cmdkey (domain)
cmdkey /add:dc01 /user:caseylab\rob /pass
