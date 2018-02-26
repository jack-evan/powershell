function get-compsysinfo {
    Param (
    [string]$srv
    )

    Get-WmiObject -Class win32_computersystem -ComputerName $srv | 
        Select-Object name, manufacturer, model

}

get-compsysinfo srv1
