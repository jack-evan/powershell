
configuration PullDemo {
    
    Node srv1 {
        WindowsFeature Backup {
            Ensure = 'Present'
            Name   = 'Windows-Server-Backup'
        }

    }
}

PullDemo

