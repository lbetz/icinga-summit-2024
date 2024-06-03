function profile::icinga::disks(
  String         $hostname,
  Array[String]  $filesystems = ['xfs', 'ext4', 'vfat'],
) >> Hash {
  $facts['mountpoints'].filter |$keys, $values| { $values['filesystem'] in $filesystems }.keys.reduce( {} ) |$memo, $disk| {
    $memo + {
      "disk $disk" =>  {
        import           => ['generic-service'],
        host_name        => $hostname,
        command_endpoint => 'host_name',
        check_command    => 'disk',
        vars             => { disk_partitions => $disk }
      }
    }
  }
}
