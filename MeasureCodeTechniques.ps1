<#
Measure-Command {
    1..10000 |
        ForEach-Object -Process {$_ * 5}
}

#>


Measure-Command {
    $range = 1..10000
    foreach ($item in $range) {
        $item * 5
    }
}


