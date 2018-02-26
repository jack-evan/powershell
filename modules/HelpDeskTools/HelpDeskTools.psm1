$CorpUserContainerPreference = ''

function New-CorpUser {
    [cmdletbinding(SupportsShouldProcess=$true,ConfirmImpact='Medium')]
    param (
        [parameter(mandatory=$true,valuefrompipelinebypropertyname=$true)][string]$FirstName,
        [parameter(mandatory=$true,valuefrompipelinebypropertyname=$true)][string]$LastName,
        [parameter(mandatory=$true,valuefrompipelinebypropertyname=$true)][string]$Department,
        [parameter(mandatory=$true,valuefrompipelinebypropertyname=$true)][string]$City,
        [parameter(mandatory=$true,valuefrompipelinebypropertyname=$true)][string]$PostalCode


    )

    process {
        $logon = "$firstname.$lastname"

        $params = @{'GivenName'=$FirstName;
                    'Surname'=$LastName;
                    'samAccountName'=$logon;
                    'name'=$logon;
                    'Department'=$Department;
                    'City'=$City;
                    'PostalCode'=$PostalCode}   
                    
        if($CorpUserContainerPreference -eq '') {
           New-ADUser @params
        } else {
            New-ADUser @params -path $CorpUserContainerPreference
          }




    }
}



Export-ModuleMember -Function New-CorpUser -Variable CorpUserContainerPreference

