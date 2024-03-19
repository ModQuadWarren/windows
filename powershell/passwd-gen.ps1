# Import System.Web assembly
Add-Type -AssemblyName System.Web

# Generate random password
[System.Web.Security.Membership]::GeneratePassword(20, 2)


function Generate-ComplexPassword {
    param (
        [int]$length = 20
    )

    # Define allowed characters (lowercase, uppercase, digits, "-", and "_")
    $allowedCharacters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_'

    # Generate the password
    $password = -join ((1..$length) | ForEach-Object { Get-Random -Maximum $allowedCharacters.Length } | ForEach-Object { $allowedCharacters[$_ - 1] })
    return $password
}

# Usage:
$newPassword = Generate-ComplexPassword
Write-Host "Generated Password: $newPassword"
