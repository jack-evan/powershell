
function CreateUser {
    [cmdletbinding()]
    param (
        #Get firstname,lastname and password
        [parameter(Mandatory = $true)]
        [string]$FirstName,

        [parameter(Mandatory = $true)]
        [string]$LastName,

        [parameter(Mandatory = $true)]
        [securestring]$Creds

    )

    begin {

        $samname = $FirstName[0] + $LastName
        $uname = "$FirstName $LastName"
        $uemail = "$samname@lab.net"
        $upn = $uemail
        

    }
    process {

        try {
            $checkuser = Get-ADUser -Identity $samname -ErrorAction stop
            write-host "User account already exists in active directory"
        }
        catch {
            if ($_ -like "*Cannot find an object with identity:*") {
                New-ADUser -Name $uname -SamAccountName $samname.ToLower() -GivenName $FirstName -Surname $LastName -UserPrincipalName $upn.ToLower() -DisplayName "$FirstName $LastName"
                Set-ADAccountPassword -Identity $samname -NewPassword $Creds -Reset
                Set-ADUser -Identity $samname -Enabled $true
                write-host "User account $FirstName $LastName created"
            }
            else {

            }

        }
            
    }
     


  

}

CreateUser