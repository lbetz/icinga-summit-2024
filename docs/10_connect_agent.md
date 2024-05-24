# Connect Agents via Zone and Endpoint Objects

```puppet
       $parent_zone = $icinga::agent::parent_zone
       $target      = "/etc/icinga2/zones.d/${parent_zone}/${node}.conf"
+
+      $_objects    = {
+        'Zone' => {
+          $zone => {
+            'endpoints' => [$node],
+            'parent'    => $parent_zone,
+          },
+        },
+        'Endpoint' => {
+          $node => {
+            'log_duration' => 0,
+          },
+        },
+      }
     } # agent
[...]

       $zone        = $icinga::server::zone
       $target      = "/etc/icinga2/zones.d/${zone}/${node}.conf"
+
+      $_objects = {}
     } # server
   }

+  deep_merge($_objects, $objects).each |String $type, Hash $objs| {
-  $objects.each |String $type, Hash $objs| {
     notify { $type:
      message => $objs.reduce({}) |$memo, $obj| {
```
