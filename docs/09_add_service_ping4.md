# Add a Service `ping4` to All Hosts

data/common.yaml:
```yaml
 ---
 profile::icinga::objects:
   Host:
     "%{lookup('icinga::cert_name')}":
       import: ['generic-host']
       display_name: "%{facts.networking.hostname}"
       address: "%{facts.networking.interfaces.eth1.ip}"
+  Service:
+    ping4:
+      host_name: "%{lookup('icinga::cert_name')}"
+      import: ['generic-service']
+      check_command: ping4
```
