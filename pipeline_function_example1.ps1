function get-csinfo {
    param(
        [string[]]$cname
    )
    begin{}
    process {
        if ($_ -ne $null) {
            $cname = $_
        }

        foreach ($i in $cname) {
             Get-WmiObject -Class win32_computersystem -ComputerName $i | 
                Select-Object name, manufacturer, model
        }
    }
    end {}
}

Get-Content C:\Users\jnunez\Documents\computers.txt | get-csinfo
