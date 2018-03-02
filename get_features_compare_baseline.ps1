#####################################################################
#creates baseline then compares features and remove any             #
#features that our outside the baseline                             #
#####################################################################

#create baseline 
#Get-WindowsFeature -ComputerName dc1 | where installed | Export-Clixml -Path C:\Users\jnunez\Desktop\baseline.html

#read baseline
#Import-Clixml -Path C:\Users\jnunez\Desktop\baseline.html

#test install telnet to compare
#Install-WindowsFeature -Name Telnet-Client -IncludeAllSubFeature -IncludeManagementTools -ComputerName dc1

#compare baseline to current installation
#Compare-Object -ReferenceObject (Import-Clixml -Path C:\Users\jnunez\Desktop\baseline.html) -DifferenceObject (Get-WindowsFeature -ComputerName dc1 | where {$_.installed}) -Property name | select -expand name

#Uninstall all features not in the baseline
#Uninstall-WindowsFeature -ComputerName dc1 -Name (Compare-Object -ReferenceObject (Import-Clixml -Path C:\Users\jnunez\Desktop\baseline.html) -DifferenceObject (Get-WindowsFeature -ComputerName dc1 | where {$_.installed}) -Property name | select -expand name)
