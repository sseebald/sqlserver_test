class profile::windows::sqlserver 
(
  $instance,
  $database,
  $admin_user,
) {

#############################
  # Required modules:
  # - jriviere/windows_isos
  # - puppetlabs/sqlserver

  # Required files:
  # - MSSQL 2014 ISO
  # - Framework 3.5
#############################

##############################

##############################
# Create the instance
##############################

  sqlserver_instance { $instance:
    ensure                => present,
    features              => ['SQL'],
    source                => 'E:\\',
    sql_sysadmin_accounts => [$admin_user],
    sa_pwd                => 'puppet123',
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
    admin_user => $admin_user,
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
