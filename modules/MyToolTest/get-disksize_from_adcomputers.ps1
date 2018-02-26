function get-disksize {

     Invoke-Command -ComputerName (Get-ADComputer -Filter * | 
     select -ExpandProperty name) {Get-PSDrive | 
     select name, @{name='Used (GB)';e={$_.Used / 1GB -as [int]}}, 
     @{name='Free (GB)';e={$_.Free / 1GB -as [int]}},
     @{name='Total (GB)';e={($_.Used + $_.Free) / 1GB -as [int]}} |
      where -Property "Used (GB)" -GT 0} |
      Format-Table -AutoSize

}

get-disksize
