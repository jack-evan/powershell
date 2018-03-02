
filter get-computersysinfo {

 Get-WmiObject -Class win32_computersystem -ComputerName $_ | 
        Select-Object name, manufacturer, model

}


Get-Content C:\Users\jnunez\Documents\computers.txt | get-computersysinfo
