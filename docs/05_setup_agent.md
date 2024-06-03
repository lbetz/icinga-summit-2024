# How to Setup an Agent

```puppet
class profile::icinga (
   case $type {
     'agent': {
       include icinga::repos
+      include icinga::agent
     } # agent

     'worker': {
```

data/common.yaml:
```yaml
 ---
 icinga::ticket_salt: topsecret
+
+icinga::agent::ca_server: changeme
+icinga::agent::parent_endpoints:
+  changeme:
+     host: "%{lookup('icinga::agent::ca_server')}"
```
