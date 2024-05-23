class profile::icinga::server (
  Enum['mysql', 'pgsql']   $db_type = 'pgsql',
) {
  class { 'icinga::server':
    ca                => true,
    config_server     => true,
    global_zones      => ['global-templates', 'linux-commands', 'windows-commands'],
    web_api_pass      => Sensitive('icingaweb2'),
    director_api_pass => Sensitive('director'),
    run_web           => true,
  }

  class { 'icinga::db':
    db_type         => $db_type,
    db_pass         => Sensitive('icingadb'),
    manage_database => true,
  }

  class { 'icinga::web':
    db_type            => $db_type,
    db_pass            => Sensitive('icingaweb2'),
    default_admin_user => 'admin',
    default_admin_pass => Sensitive('admin'),
    manage_database    => true,
    api_pass           => $icinga::server::web_api_pass,
  }

  class { 'icinga::web::icingadb':
    db_type => $icinga::db::db_type,
    db_pass => $icinga::db::db_pass,
  }
}
