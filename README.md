# sqlserver_test

Required modules are:
```
 - puppetlabs/mount_iso, grab from: https://github.com/puppetlabs/puppetlabs-mount_iso
 - puppetlabs/sqlserver
 - puppetlabs/acl
```

Tested on PE 3.8.2, Windows Server 2012 R2

Classify through console or in site.pp like this:
```
  class { 'profile::windows::sqlserver':
    iso_path => 'C:\tmp\SQLServer2014-x64-enu.iso',
    iso_drive => 'E:/',
    instance => 'my_instance',
    admin_user => 'vagrant',
    database => 'test1',
  }
```
