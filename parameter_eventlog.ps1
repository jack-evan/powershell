Invoke-Command -ComputerName (Get-ADComputer -Filter * | select -ExpandProperty name) -ScriptBlock { param($a,$b) Get-EventLog -LogName $a -Newest $b } -ArgumentList $logname,$quan
tity