# Icinga Config Objects on the Server

```puppet
class profile::icinga (
   Enum['agent', 'worker', 'server']   $type = 'agent',
+  Hash[String, Hash]                  $objects = {},
 ) {

[...]

+  $objects.each |String $type, Hash $objs| {
+    notify { $type:
+      message => $objs,
+    }
+  }
 }
```

data/nodes/<your server>.yaml:
```yaml
profile::icinga::objects:
  Host:
    generic-host:
      template: true
      check_command: hostalive
      check_interval: 1m
      retry_interval: 30s
      max_check_attempts: 3
      target: /etc/icinga2/zones.d/global-templates/templates.conf
  Service:
    generic-service:
      template: true
      check_interval: 1m
      retry_interval: 30s
      max_check_attempts: 3
      target: /etc/icinga2/zones.d/global-templates/templates.conf
```
