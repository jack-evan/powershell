function update_xm {
    [cmdletbinding()]
    param(fasdfasddfsdfa
        [parameter(mandatory=$true,valuefrompipeline=$true)][xml]$xml
    
    )

    [xml]$xml = Get-Content C:\Users\jnunez\Documents\WindowsPowerShell\serverdata.xml
    $xml

    foreach($computer in $xml.computers.computer) {
        #query information
        $bios = Get-WmiObject -Class win32_bios -ComputerName $computer.name
        $sys = Get-WmiObject -Class win32_computersystem -ComputerName $computer.name
        $os = Get-WmiObject -Class win32_operatingsystem -ComputerName $computer.name


        #update xml and add value to xml element
        $computer.biosserial = $biosserial


        #create new node for mfgr
        $new_node = $xml.CreateNode("element","manufacturer","")
        $new_node.InnerText = $sys.manufacturer
        $computer.AppendChild($new_node) | Out-Null

        #create attribute
        $new_attr = $xml.CreateAttribute('build')
        $new_attr.Value = $os.buildnumber
        $computer.SetAttributeNode($new_attr) | Out-Null

        
    }

    $xml.InnerXml

    <#
    $node = $xml.SelectSingleNode("//computer[@name='dc1.lab.net']")
    write "the node name is $($node.name)"
    #>


}

