


param (
    [string[]]$computerName
)


foreach($i in $computername) {
   try {
        Test-Connection -ComputerName $i -ErrorAction stop -ev x
   } catch {
        
            $myerror = "$i did not respond"
            Write-Host $myerror
        
        
   }



}

