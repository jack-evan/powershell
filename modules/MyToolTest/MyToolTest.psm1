function Get-SecLogNewest100 {
    param (
        [string]$compuname
    )
    Get-EventLog -LogName Security -Newest 100 -ComputerName $compuname
    
}


function Get-OSInfo {
    param (
        [string]$compuname
    )
    Get-CimInstance -ClassName win32_bios -ComputerName $compuname

}


