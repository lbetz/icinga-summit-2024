# Additional Services for the Server

```puppet
 class profile::icinga (
[...]

-      $_objects = {}
+      $_objects = {
+        'Service' => {
+          'icinga' => {
+            'host_name'        => $node,
+            'import'           => ['generic-service'],
+            'check_command'    => 'icinga',
+          },
+          'icingadb' => {
+            'host_name'        => $node,
+            'import'           => ['generic-service'],
+            'check_command'    => 'icingadb',
+          },
+        },
+      }

       # Collect all eported Icinga config objects
       class { 'icinga2::query_objects':
         destination  => $config_server,
       }
     } # server
```
