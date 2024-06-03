class profile::icinga (
  String                              $config_server,
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
      $export      = $config_server

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
        'Service' => {
          'icinga' => {
            'host_name'        => $node,
            'import'           => ['generic-service'],
            'check_command'    => 'icinga',
            'command_endpoint' => 'host_name',
          },
          'cluster zone' => {
            'host_name'        => $node,
            'import'           => ['generic-service'],
            'check_command'    => 'cluster-zone',
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
      $export   = []

      $_objects = {}

      # Collect all eported Icinga config objects
      class { 'icinga2::query_objects':
        destination  => $config_server,
      }
    } # server
  }

  deep_merge($_objects, $objects).each |String $type, Hash $objs| {
    ensure_resources(
      downcase("icinga2::object::$type"),
      $objs.reduce({}) |$memo, $obj| {
        if $obj[1]['target'] {
          $memo + { $obj[0] => $obj[1] + {
              'export' => $export }}
        } else {
          $memo + { $obj[0] => $obj[1] + {
              'export' => $export,
              'target' => $target }}
        }
      }
    ) 
  }
}
