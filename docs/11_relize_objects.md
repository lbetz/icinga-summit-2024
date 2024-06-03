# Connect Agents via Zone and Endpoint Objects

```puppet
 class profile::icinga (
+  String                              $config_server,
   Enum['agent', 'worker', 'server']   $type = 'agent',
[...]

       $parent_zone = $icinga::agent::parent_zone
       $target      = "/etc/icinga2/zones.d/${parent_zone}/${node}.conf"
+      $export      = $config_server

       $_objects    = {
         'Zone' => {
[...]

       $zone        = $icinga::server::zone
       $target      = "/etc/icinga2/zones.d/${zone}/${node}.conf"
+      $export      = []

       $_objects = {}
+
+      # Collect all eported Icinga config objects
+      class { 'icinga2::query_objects':
+        destination  => $config_server,
+      }
     } # server
   }

  deep_merge($_objects, $objects).each |String $type, Hash $objs| {
-   notify { $type:
+   ensure_resources(
+     downcase("icinga2::object::$type"),
-     message => $objs.reduce({}) |$memo, $obj| {
+     $objs.reduce({}) |$memo, $obj| {
        if $obj[1]['target'] {
-         $memo + { $obj[0] => $obj[1] }
+         $memo + { $obj[0] => $obj[1] + {
+             'export' => $export }}
        } else {
          $memo + { $obj[0] => $obj[1] + {
+             'export' => $export,
              'target' => $target }}
        }
      }
+   ) 
  }
```
