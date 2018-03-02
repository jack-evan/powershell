

function savetosql {
    [CmdletBinding()]
    param (
        [parameter(mandatory = $True, ValueFromPipeline = $true)][object[]]$inputobject


    )

    #connection string
    $ConnString = "Server=SRV1\SQLEXPRESS;Database=AdminData;Trusted_Connection=True;"

    #insert data
    $sql = "Insert into dbo.DiskData (ComputerName,DriveLetter,FreeSpace,Size,FreePercent) VALUES ('$($inputobject.computername)','$($inputobject.drive)','$($inputobject.freespace)','$($inputobject.size)','$($inputobject.freepercent))"
    #$sql = "Insert into dbo.DiskData (ComputerName,DriveLetter,FreeSpace,Size,FreePercent) VALUES ('tst','C','30','45','95')"
    
    #connect 
    $conn = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $conn.ConnectionString = $ConnString
    $conn.Open()

    #setup command
    $cmd = New-Object -TypeName System.Data.SqlClient.SqlCommand
    $cmd.Connection = $conn
    $cmd.CommandText = $sql
    $cmd.ExecuteNonQuery()



    $conn.Close()


}

savetosql