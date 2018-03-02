[cmdletbinding()]
param (
    [parameter(Mandatory = $true)][string[]]$ComputerName,
    [parameter(Mandatory = $true)][int]$MinFreeSpace
)

get-diskdetails -computername $ComputerName | 
    Where-Object FreePercent -LT $MinFreeSpace |
    Select-Object ComputerName, FreePercent, Drive |
    format-table -autosize |
    Out-File c:\users\jnunez\desktop\ProblemDisks.txt

