
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
  
       

        $sql = "Insert INTO DiskData (ComputerName,DriveLetter,FreeSpace,Size,FreePercent) VALUES ('$($inputobject.computername)','$($inputobject.drive),$($inputobject.freespace),$($inputobject.size),$($inputobject.freepercent))"
        Write-Debug "Executing $sql"
        $command.CommandText = $sql
        $command.ExecuteNonQuery()
    }

    end {
        $connection.Close()
    }


}
