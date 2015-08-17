# sqlserver_test

Required modules are:
```
 - puppetlabs/mount_iso, grab from:
 - puppetlabs/sqlserver
```

Tested on PE 3.8.2

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
