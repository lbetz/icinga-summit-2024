class profile::icinga (
  Enum['agent', 'worker', 'server']   $type    = 'agent',
  Hash[String, Hash]                  $objects = {},
) {

  case $type {
    'agent': {
      include icinga::repos
      include icinga::agent
    } # agent

    'worker': {
      include icinga::repos
    } # worker

    'server': {
      class { 'icinga::repos':
        manage_extras => true,
      }
      include profile::icinga::server
    } # server
  }

  $objects.each |String $type, Hash $objs| {
    notify { $type:
      message => $objs,
    }
  }
}
