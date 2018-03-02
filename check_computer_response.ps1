


function check {
    param (
        [string]$computer

    )
    $alive = $true
    if (Test-Connection -ComputerName $computer -Quiet) {
        try {
            Get-WmiObject win32_bios -ComputerName $computer -ErrorAction Stop | Out-Null
        } catch {
            $alive = $false
        }
    } else {
        $alive = $false 
    }
    return $alive
    

}

check dc1

