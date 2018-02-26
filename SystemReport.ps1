$css = @"

body {
    font-family:Tahoma;
    font-size:10pt;
    background-color:white;
    color:#333;
}

h2 {
    cursor:pointer;

}

h2:hover {
    color:blue;
}

.even { background-color:#eee; }
.odd { background-color:#666; }
.paginate_disabled_previous,
.paginate_disabled_next {
    padding:4px;
    color:#ddd;
}
.paginate_enabled_previous,
.paginate_enabled_next {
    padding:4px;
    color:blue;
    cursor:pointer;
}


"@

$frag1 = get-systemdetails -computername dc1.lab.net |
         ConvertTo-EnhancedHTMLFragment -TableCssID SYSTABLE `
                                        -DivCssID SYSDIV `
                                        -DivCssClass WHATEVER `
                                        -TableCssClass TABLEWHATEVER `
                                        -As List `
                                        -Properties * `
                                        -MakeHiddenSection `
                                        -PreContent '<h2>System Details</h2>' |
        Out-String
                                        


$frag2 = get-diskdetails -computername dc1.lab.net |
         ConvertTo-EnhancedHTMLFragment -TableCssID DISKTABLE `
                                        -DivCssID DISKDIV `
                                        -DivCssClass WHATEVER `
                                        -TableCssClass TABLEWHATEVER `
                                        -As Table `
                                        -Properties * `
                                        -EvenRowCssClass 'even' `
                                        -OddRowCssClass 'odd' `
                                        -MakeHiddenSection `
                                        -PreContent '<h2>Disks</h2>' |
        Out-String


$frag3 = get-process -computername dc1.lab.net |
         ConvertTo-EnhancedHTMLFragment -TableCssID PROCTABLE `
                                        -DivCssID PROCDIV `
                                        -DivCssClass WHATEVER `
                                        -TableCssClass TABLEWHATEVER `
                                        -As Table `
                                        -Properties Name,ID,VM,PM,WS,CPU `
                                        -EvenRowCssClass 'even' `
                                        -OddRowCssClass 'odd' `
                                        -MakeHiddenSection `
                                        -MakeTableDynamic `
                                        -PreContent '<h2>Processes</h2>' |
        Out-String
                                       
                                       


ConvertTo-EnhancedHTML -HTMLFragments $frag1,$frag2,$frag3 `
                       -Title "System Report for DC1.LAB.NET" `
                       -PreContent "<h1>System report for dc1.lab.net</h1>" `
                       -PostContent "<br></br>Retrieved $(Get-Date)" `
                       -CssStyleSheet $css |

Out-File C:\Users\jnunez\Documents\System_Report.html


