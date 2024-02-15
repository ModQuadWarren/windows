## ENABLE PSREMOTING ON WINDOWS SERVER ##
# check current WSMan Trusted Hosts:
Get-Item WSMan:\localhost\Client\TrustedHosts

# add to TrustedHosts after enabling PSRemoting
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "dc01,dc02,dc03,mssql01,srv01"

# check current WSMan delegates:
(Get-Item WSMan:\localhost\Client\TrustedHosts).Value

# add delegate computer
Enable-WSManCredSSP -Role client -DelegateComputer dc03

# add cmdkey
cmdkey /add:dc03 /user:caseylab\rob /pass