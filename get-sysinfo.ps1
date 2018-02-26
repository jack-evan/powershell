function get-sysinfo {
<#
.SYNOPSIS
gets system information
.DESCRIPTION
gets system information, accpets multiple parameters
.PARAMETER
computername
.EXAMPLES
 get-sysinfo -computerName compu1,compu2
#>
    param (
        [string[]]$computerName
    )

    foreach ($i in $computerName) {

        $os = Get-WmiObject -Class Win32_operatingsystem -ComputerName $i
        $cs = Get-WmiObject -Class Win32_computersystem -ComputerName $i
        $bios = Get-WmiObject -Class Win32_bios -ComputerName $i

        $props = @{'ComputerName'=$i;
                   'OSVersion'=$os.version;
                   'SPVersion'=$os.servicepackmajorversion;
                   'Mfgr'=$cs.manufacturer;
                   'Model'=$cs.model;
                   'RAM'=$cs.totalphysicalmemory;
                   'BIOSSerial'=$bios.serialnumber
                  }

        $obj = New-Object -TypeName PSObject -Property $props
        Write-Output $obj



    }
}