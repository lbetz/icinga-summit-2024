# Expand Hosts for Icinga Agents

```puppet
 class profile::icinga (
[...]
     'agent': {
       include icinga::repos
       include icinga::agent
+
+      $node        = $icinga::cert_name
+      $zone        = $node
+      $parent_zone = $icinga::agent::parent_zone
+      $target      = "/etc/icinga2/zones.d/${parent_zone}/${node}.conf"
     } # agent
[...]
       include profile::icinga::server
+
+      $node        = $icinga::cert_name
+      $zone        = $icinga::server::zone
+      $target      = "/etc/icinga2/zones.d/${zone}/${node}.conf"
     } # server
   }
```
