$ExampleErrorLogFile = 'C:\Users\jnunez\Desktop\Disk_Error.txt'

function get-systemdetails {
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true,
            valuefrompipeline=$true,
            valuefrompipelinebypropertyname=$true)]
        [string[]]$computername

        
    )

    process {
        foreach($computer in $computerName) {
            if (checkcomputer $computer) {
                        $os = Get-WmiObject Win32_operatingsystem -ComputerName $computer
                        $cs = Get-WmiObject Win32_ComputerSystem -ComputerName $computer
                        $bios = Get-WmiObject Win32_Bios -ComputerName $computer

                        $props = @{'ComputerName'=$computer;
                                   'OSVersion'=$os.version;
                                   'SPVersion'=$os.servicepackmajorversion;
                                   'OSBuild'=$os.buildnumber;
                                   'Manufacturer'=$cs.manufacturer;
                                   'Model'=$cs.model;
                                   'BIOSSerial'=$bios.serialnumber

                        }
                    $obj = New-Object -TypeName psobject -Property $props
                    Write-Output $obj
        
            }

          
        }
    
    }


}


function get-diskdetails {
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true,
            valuefrompipeline=$true,
            valuefrompipelinebypropertyname=$true)]
        [string[]]$computername
    )

    begin {
        Remove-Item -Path $ExampleErrorLogFile -ErrorAction SilentlyContinue
    }

    process {
        foreach($computer in $computerName) {
            if (checkcomputer $computer) {
                $disks = Get-WmiObject Win32_LogicalDisk -Filter 'DriveType=3' -ComputerName $computer
            
                        foreach($disk in $disks) {
                            $props = @{'ComputerName'=$computer;
                                       'Drive'=$disk.deviceid;
                                       'FreeSpace'="{0:N2}" -f ($disk.freespace / 1GB);
                                       'Size'="{0:N2}" -f ($disk.size / 1GB)
                                       'FreePercent'="{0:N2}" -f ($disk.freespace / $disk.size * 100)


            }
        
                           
            
                            }
            
             $obj = New-Object -TypeName psobject -Property $props
             Write-Output $obj
            }


           
        }
    
    }


}





function Save-DiskDetailsToSQLDatabase {
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true, valuefrompipeline=$true)][object[]]$inputobject


    )

    begin {
        $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = "Server=SRV1\SQLEXPRESS;Database=AdminData;Trusted_Connection=True;"
        $connection.Open()

    }

    process {
        $command = New-Object -TypeName System.Data.SqlClient.SqlCommand
        $command.Connection = $connection
        

        $sql = "DELETE FROM DiskData WHERE ComputerName = '$($inputobject.computername)' and DriveLetter = '$($inputobject.drive)'"
        Write-Debug "Executing $sql"
        $command.CommandText = $sql
        $command.ExecuteNonQuery()
  
       

        $sql = "Insert INTO DiskData (ComputerName,DriveLetter,FreeSpace,Size,FreePercent) VALUES ('$($inputobject.computername)','$($inputobject.drive)','$($inputobject.freespace)','$($inputobject.size)','$($inputobject.freepercent))"
        Write-Debug "Executing $sql"
        $command.CommandText = $sql
        $command.ExecuteNonQuery()
    
    }

    end {
        $connection.Close()
    }


}








function checkcomputer {
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


#Export-ModuleMember -Function get-diskdetails, get-systemdetails, Save-DiskDetailsToSQLDatabase



function set-computerstate {
  [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High')]
    param (
        [parameter(mandatory=$true,valuefrompipeline=$true)]
        [string[]]$computername,

        [parameter(mandatory=$true)]
        [validateset('LogOff','PowerOff','Shutdown','Restart')]
        [string]$action

        )

    process {
        foreach($computer in $computername) {
        
        switch($action ) {
            'LogOff' {$x = 0}
            'Shutdown' {$x = 1}
            'Restart' {$x = 2}
            'PowerOff' {$x = 8}


        }

        if ($force) {$x += 4}
        $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer -EnableAllPrivileges
        if($pscmdlet.ShouldProcess("$action $computer")) {

        $os.win32shutdown($x) | Out-Null
        }
    }

   
}