<?php
// https://github.com/elijaa/phpmemcachedadmin

list($hostname, $port) = explode(':', getenv('OFF_MEMCACHE_SERVERS'));

return [
  'stats_api' => 'Server',
  'slabs_api' => 'Server',
  'items_api' => 'Server',
  'get_api' => 'Server',
  'set_api' => 'Server',
  'delete_api' => 'Server',
  'flush_all_api' => 'Server',
  'connection_timeout' => 1,
  'max_item_dump' => 100,
  'refresh_rate' => 2,
  'memory_alert' => 80,
  'hit_rate_alert' => 90,
  'eviction_alert' => 0,
  'file_path' => 'Temp',
  'servers' => [
    'Default' => [
      "$hostname:$port" => [
        'hostname' => $hostname,
        'port' => $port,
      ],
    ],
  ],
];
