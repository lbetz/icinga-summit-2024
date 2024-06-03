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
   $objects.each |String $type, Hash $objs| {
     notify { $type:
-      message => $objs,
+      message => $objs.reduce({}) |$memo, $obj| {
+        if $obj[1]['target'] {
+          $memo + { $obj[0] => $obj[1] }
+        } else {
+          $memo + { $obj[0] => $obj[1] + {
+              'target' => $target }}
+        }
+      },
     }
   }
