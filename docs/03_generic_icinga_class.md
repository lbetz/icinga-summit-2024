# A Generic Icinga Class

Do not forget to customize your site manifest!

class profile::icinga (
  Enum['agent', 'worker', 'server']   $type = 'agent',
) {

  case $type {
    'agent': {
      include icinga::repos
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
}
```

Reference of [icinga::repos](https://github.com/voxpupuli/puppet-icinga/blob/main/REFERENCE.md#icinga--repos)
