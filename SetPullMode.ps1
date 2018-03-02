configuration SetPullMode
{
    Node srv1
    {
        LocalConfigurationManager {
            ConfigurationMode         = 'ApplyOnly'
            ConfigurationID           = '966befbc-9777-4fc3-815c-bd122524739d'

            RefreshMode               = 'Pull'
            DownloadManagerName       = 'WebDownloadManager'
            DownloadManagerCustomData = @{
                ServerURL               = 'https://dsc1:8080/PSDSCPullServer.svc';
                AllowUnsecureConnection = 'true' 
            }
            RefreshFrequencyMins      = 5
            
        }
            
    }
}

SetPullMode
