$message = ""
$continue = $true

do {

    Write-Host "======================================================="
    Write-Host "                       Support Menu                    "
    Write-Host "======================================================="
    Write-Host ""
    if ($message -ne "") {
        Write-Host $message
        Write-Host ""
    
    }

    Write-Host "1. Get system details"
    Write-Host "2. Get disk details  "
    Write-Host "X. Quit menu"
    Write-Host ""
    $message = ""
    $choice = Read-Host "Select activity"
    switch ($choice) {
        1 { get-systemdetails}
        2 { get-diskdetails}
        'X' { $continue = $false }
        default { $message = "Unknown choice, try again"}
    }

    Read-Host "Hit any key to continue"
    Clear-Host

} while ($continue)
Write-Host "Exited Mneu.."

