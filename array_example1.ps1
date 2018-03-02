$arr1 = 'cbtnuggets.com','gmail.com','company.com'
$arr2 = 'nuggetlab.com','outlook.com','company.pri'

$emails = 'don@cbtnuggets.com','joe@gmail.com','tom@company.com'

foreach($email in $emails) {
for ([int]$x = 0; $x -lt $arr1.Count; $x++) {
    
    $email = $email -replace $arr1[$x],$arr2[$x]
    }
    Write-Output $email
    }
