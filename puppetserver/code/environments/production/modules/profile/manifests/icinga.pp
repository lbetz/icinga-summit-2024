class profile::icinga (
  Enum['agent', 'worker', 'server']   $type    = 'agent',
  Hash[String, Hash]                  $objects = {},
) {

  case $type {
    'agent': {
      include icinga::repos
      include icinga::agent

      $node        = $icinga::cert_name
      $zone        = $node
      $parent_zone = $icinga::agent::parent_zone
      $target      = "/etc/icinga2/zones.d/${parent_zone}/${node}.conf"
    } # agent

    'worker': {
      include icinga::repos
    } # worker

    'server': {
      class { 'icinga::repos':
        manage_extras => true,
      }
      include profile::icinga::server

      $node        = $icinga::cert_name
      $zone        = $icinga::server::zone
      $target      = "/etc/icinga2/zones.d/${zone}/${node}.conf"
    } # server
  }

  $objects.each |String $type, Hash $objs| {
    notify { $type:
      message => $objs.reduce({}) |$memo, $obj| {
        $memo + { $obj[0] => $obj[1] + {
            'target' => $target }}
      },
    }
  }
}
