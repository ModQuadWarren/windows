:: This batch file checks for network connection problems
:: and saves the output to a .txt file.
ECHO OFF
:: View network connection details
ipconfig /all >>  results.txt
:: Check if Google.com is reachable
ping google.com >> results.txt
:: Run a traceroute to check the route to Google.com
tracert google.com >> results.txt