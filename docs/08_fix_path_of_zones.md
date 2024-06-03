# Fix the Path Problem of Zones

```puppet
 class profile::icinga (
[...]

      message => $objs.reduce({}) |$memo, $obj| {
-       $memo + { $obj[0] => $obj[1] + {
-           'target' => $target }}
+       if $obj[1]['target'] {
+         $memo + { $obj[0] => $obj[1] }
+       } else {
+         $memo + { $obj[0] => $obj[1] + {
+             'target' => $target }}
+       }
      },
    }
```
