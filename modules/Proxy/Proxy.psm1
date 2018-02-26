function export-csv {

    [CmdletBinding(DefaultParameterSetName='Delimiter', SupportsShouldProcess=$true, ConfirmImpact='Medium', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113299')]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Path},

        [Alias('PSPath')]
        [ValidateNotNullOrEmpty()]
        [string]
        ${LiteralPath},

        [switch]
        ${Force},

        [Alias('NoOverwrite')]
        [switch]
        ${NoClobber},

        [ValidateSet('Unicode','UTF7','UTF8','ASCII','UTF32','BigEndianUnicode','Default','OEM')]
        [string]
        ${Encoding},

        [switch]
        ${Append},

        [Parameter(ParameterSetName='UseCulture')]
        [switch]
        ${UseCulture},

        [Alias('NTI')]
        [switch]
        ${NoTypeInformation})

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Export-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\Export-Csv
    .ForwardHelpCategory Cmdlet

    #>



}



function export-html {

    [CmdletBinding(DefaultParameterSetName='Page', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113290', RemotingCapability='None')]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0)]
        [System.Object[]]
        ${Property},

        [Parameter(Mandatory=$True)]
        [string]
        $Path,


        [Parameter(ParameterSetName='Page', Position=3)]
        [string[]]
        ${Body},

        [Parameter(ParameterSetName='Page', Position=1)]
        [string[]]
        ${Head},

        [Parameter(ParameterSetName='Page', Position=2)]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Title},

        [ValidateNotNullOrEmpty()]
        [ValidateSet('Table','List')]
        [string]
        ${As},

        [Parameter(ParameterSetName='Page')]
        [Alias('cu','uri')]
        [ValidateNotNullOrEmpty()]
        [uri]
        ${CssUri},

        [Parameter(ParameterSetName='Fragment')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${Fragment},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PostContent},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PreContent})

    begin
    {
        $_path = $Path
        $PSBoundParameters.Remove('Path')
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Html', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters | out-file -FilePath $_path }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Html
    .ForwardHelpCategory Cmdlet

    #>



}