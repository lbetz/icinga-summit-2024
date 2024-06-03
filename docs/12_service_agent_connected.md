# Agent Connection Monitoring

```puppet
 class profile::icinga (
[...]

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
+        'Service' => {
+          'icinga' => {
+            'host_name'        => $node,
+            'import'           => ['generic-service'],
+            'check_command'    => 'icinga',
+            'command_endpoint' => 'host_name',
+          },
+          'cluster zone' => {
+            'host_name'        => $node,
+            'import'           => ['generic-service'],
+            'check_command'    => 'cluster-zone',
+          },
         },
       }
     } # agent
```
