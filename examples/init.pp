# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#
include cloudflare

cfrecord {$::hostname:
  ensure   => present,
  zone     => 'nextworking.nl',
  type     => 'A',
  content  => [$::ipaddress],
  cf_key   => '',
  cf_email =>  'bas@wildemann.nl',
}

cfrecord {'nextworking.nl':
  ensure   => present,
  zone     => 'nextworking.nl',
  type     => 'A',
  content  => '82.197.193.129',
  cf_key   => '',
  cf_email => 'bas@wildemann.nl',
}
