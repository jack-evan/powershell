

function get-disksize {
<#
.NAME
get-disksize
.SYNTAX
get-disksiz 1
.SYNOPSIS
gets disk size information

.DESCRIPTION
gets disk information, accpets multiple parameters

.PARAMETER
computername

.EXAMPLES
get-sysinfo -computerName compu1,compu2
#>


     Invoke-Command -ComputerName (Get-ADComputer -Filter * | 
     select -ExpandProperty name) {Get-PSDrive | 
     select name, @{name='Used (GB)';e={$_.Used / 1GB -as [int]}}, 
     @{name='Free (GB)';e={$_.Free / 1GB -as [int]}},
     @{name='Total (GB)';e={($_.Used + $_.Free) / 1GB -as [int]}} |
      where -Property "Used (GB)" -GT 0} |
      Format-Table -AutoSize

}


