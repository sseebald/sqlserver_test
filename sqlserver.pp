class profile::windows::sqlserver 
(
  $instance,
  $admin_user,
  $database,
  $iso_drive
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
    source   => $iso_drive,
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
