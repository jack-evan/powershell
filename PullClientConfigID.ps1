[DSCLocalConfigurationManager()]
configuration PullClientConfigID
{
    Node srv1
    {
        Settings {
            RefreshMode          = 'Pull'
            ConfigurationID      = '966befbc-9777-4fc3-815c-bd122524739d'
            RefreshFrequencyMins = 30 
            RebootNodeIfNeeded   = $true
        }
        ConfigurationRepositoryWeb CONTOSO-PullSrv {
            ServerURL = 'https://dsc1:8080/PSDSCPullServer.svc'

        }      
    }
}
PullClientConfigID