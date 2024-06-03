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

      $_objects    = {
        'Zone' => {
          $zone => {
            'endpoints' => [$node],
            'parent'    => $parent_zone,
          },
        },
        'Endpoint' => {
          $node => {
            'log_duration' => 0,
          },
        },
      }
    } # agent

    'worker': {
      include icinga::repos
    } # worker

    'server': {
      class { 'icinga::repos':
        manage_extras => true,
      }
      include profile::icinga::server

      $node     = $icinga::cert_name
      $zone     = $icinga::server::zone
      $target   = "/etc/icinga2/zones.d/${zone}/${node}.conf"

      $_objects = {}
    } # server
  }

  deep_merge($_objects, $objects).each |String $type, Hash $objs| {
    notify { $type:
      message => $objs.reduce({}) |$memo, $obj| {
        if $obj[1]['target'] {
          $memo + { $obj[0] => $obj[1] }
        } else {
          $memo + { $obj[0] => $obj[1] + {
              'target' => $target }}
        }
      },
    }
  }
}
