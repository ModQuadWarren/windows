# Check $env variables for JAVA_HOME/JRE_HOME and CATALINA
Write-Output $env:JAVA_HOME
# OR #
Write-Output $env:JRE_HOME
# AND#
Write-Output $env:CATALINA_HOME

# Setting JAVA_HOME
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jre-1.8\bin", [System.EnvironmentVariableTarget]::Machine)

# Setting JRE_HOME (optional)
[Environment]::SetEnvironmentVariable("JRE_HOME", "C:\Program Files\Java\jre-1.8\bin", [System.EnvironmentVariableTarget]::Machine)

# Setting CATALINA_HOME (optional)
[Environment]::SetEnvironmentVariable("CATALINA_HOME", "C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin", [System.EnvironmentVariableTarget]::Machine)

# Adding JDK and JRE bin directories to PATH (optional)
$jdkBin = "C:\Program Files\Java\jdk1.8.0_291\bin"
$jreBin = "C:\Program Files\Java\jre1.8.0_291\bin"
$currentPath = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$newPath = "$jdkBin;$jreBin;$currentPath"
[Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::Machine)


# Check if Tomcat10 service is running
Get-Service -Name "Tomcat10" | Select-Object -ExpandProperty Status

# start service
Start-Service -Name "Tomcat10"

# check logs
Get-ChildItem -Path "C:\Program Files\Apache Software Foundation\Tomcat 10.1\logs\" | Sort-Object LastWriteTime -Descending


# HTTP stuff
curl condor.depaul.edu/mkalin/