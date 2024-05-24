# A Generic Icinga Class

```puppet
class profile::icinga (
  Enum['agent', 'worker', 'server']   $type = 'agent',
) {

  case $type {
    'agent': {
      include icinga::repos
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
```

Reference of [icinga::repos](https://github.com/voxpupuli/puppet-icinga/blob/main/REFERENCE.md#icinga--repos)
