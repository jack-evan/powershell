

Write-Host "x is $x"
$x = 200
Write-Host "in this script, x is $x"

function foo {
    Write-Host "in this function, x is $x"

    $x = 300

    Write-Host "now, x ix $x in the function"


}


foo

Write-Host "at this point x is $x"
