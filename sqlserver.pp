class profile::windows::sqlserver 
(
  $instance,
  $admin_user,
  $database,
) {

#############################
  # Required modules:
  # - puppetlabs/mount_iso
  # - puppetlabs/sqlserver

  # Required files:
  # - MSSQL 2014 ISO
  # - Framework 3.5
#############################

##############################

  acl { $iso_path :
    permissions => [
      {
        identity => 'Everyone',
        rights   => [ 'full' ]
      },
      {
        identity => $::staging::owner,
        rights   => [ 'full' ]
      },
    ],
    before      => Mount_iso[$iso_path],
  }

  mount_iso { $iso_path :
    drive_letter => $iso_drive,
    before => Sqlserver_instance[$instance],
  }

##############################
# Create the instance
##############################

  sqlserver_instance { $instance:
    ensure                => present,
    features              => ['SQL'],
    source                => $iso_drive,
    sql_sysadmin_accounts => [$admin_user],
    sa_pwd                => 'puppet123',
    security_mode => 'SQL',
  }

###############################

###############################
# Decide on features
###############################

  sqlserver_features { 'Generic Features':
    source   => 'E:\\',
    features => ['Tools'],
  }

###############################

###############################
## Set up login
###############################

  sqlserver::config { $instance: 
    admin_user => 'sa',
    admin_pass => 'puppet123',
  }

#  sqlserver::login { 'test1':
#    instance => $instance,
#  } 

###############################

###############################
# Set up the databases
###############################

  sqlserver::database { $database:
    ensure   => present,
    instance => $instance,
  }

##############################

}
