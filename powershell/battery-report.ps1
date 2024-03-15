New-Item -Path C:\temp -ItemType Directory -Force
Set-Location C:\temp
powercfg.exe -batteryreport
Start-Process "battery-report.html"
