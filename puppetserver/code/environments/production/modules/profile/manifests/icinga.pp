class profile::icinga (
  Enum['agent', 'worker', 'server']   $type    = 'agent',
) {

  case $type {
    'agent': {
      include icinga::repos
      include icinga::agent
    }
    'worker': {
      include icinga::repos
    }
    'server': {
      class { 'icinga::repos':
        manage_extras => true,
      }

      include profile::icinga::server
    }
  }
}
