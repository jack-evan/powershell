[cmdletbinding()]
param (
    [parameter(mandatory=$true,valuefrompipeline=$true,valuefrompipelinebypropertyname=$true)]
    [string[]]$ComputerName,

    [parameter(mandatory=$true)]
    [string]$outputpath

)


begin {
    if (Test-Path $outputpath) {
        # exists
    } else {
        mkdir $outputpath | Out-Null
    }


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

}

process {
    foreach($comp in $ComputerName) {

    $frag1 = get-systemdetails -computername $comp |
             ConvertTo-EnhancedHTMLFragment -TableCssID SYSTABLE `
                                            -DivCssID SYSDIV `
                                            -DivCssClass WHATEVER `
                                            -TableCssClass TABLEWHATEVER `
                                            -As List `
                                            -Properties * `
                                            -MakeHiddenSection `
                                            -PreContent '<h2>System Details</h2>' |
            Out-String
                                        


    $frag2 = get-diskdetails -computername $comp |
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


    $frag3 = get-process -computername $comp |
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
                                       
                                       
    $path = Join-Path -Path $outputpath -ChildPath "$comp.html" 

    ConvertTo-EnhancedHTML -HTMLFragments $frag1,$frag2,$frag3 `
                           -Title "System Report for $comp" `
                           -PreContent "<h1>System report for $comp</h1>" `
                           -PostContent "<br></br>Retrieved $(Get-Date)" `
                           -CssStyleSheet $css |

    Out-File $path

    }

}

#how to use: get-adcomputer -filter 'name -like "srv*"' | select -expandperoperty name | systemreport.ps1 -outputpath c:\reports
