# Default Settings in Hiera

data/common.yaml:
```yaml
---
icinga::ticket_salt: topsecret
```

data/RedHat/common.yaml:
```yaml
---
icinga::repos:
  icinga-stable-release:
    baseurl: 'https://packages.icinga.com/subscription/rhel/$releasever/release/'
    username: icinga-summit-2024
    password: Summit2024
icinga::repos::manage_epel: true
icinga::repos::manage_powertools: true
icinga::repos::manage_crb: true
```

data/Debian/Debian/12.yaml:
```yaml
---
php::globals::php_version: '8.2'
mysql::server::override_options:
  mysqld:
    log-error: ~
```
