# Add Host Config Objects for every Host

data/common.yaml
```yaml
+icinga::cert_name: "%{facts.networking.fqdn}"
 icinga::ticket_salt: topsecret

 icinga::agent::parent_endpoints:
   server.icinga.summit2024.berlin:
      host: "%{lookup('icinga::agent::ca_server')}"
+
+profile::icinga::objects:
+  Host:
+    "%{lookup('icinga::cert_name')}":
+      import: ['generic-host']
+      display_name: "%{facts.networking.hostname}"
+      address: "%{facts.networking.ip}"
+
+lookup_options:
+  'profile::icinga::objects':
+    merge:
+      strategy: deep
```

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

   $objects.each |String $type, Hash $objs| {
     notify { $type:
-      message => $objs,
+      message => $objs.reduce({}) |$memo, $obj| {
+        $memo + { $obj[0] => $obj[1] + {
+            'target' => $target }}
+      },
     }
   }
```
