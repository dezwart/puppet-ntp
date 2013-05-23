# ntp service
#
# == Parameters
#
# [*servers*]
#   List of upstream NTP servers.
#
# [*use_pool*]
#   Boolean flag to control the use of an NTP pool.
#
# == Variables
#
# == Examples
#
#  class { 'ntp':
#    servers  => [ 'ntp0.example.com', 'ntp1.example.com' ],
#    use_pool => false,
#  }
#
class ntp(
  $servers = undef,
  $use_pool = true
) {
  package { 'ntp':
    ensure  => installed,
  }

  file { '/etc/ntp.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('ntp/ntp.conf.erb'),
    require => Package['ntp'],
  }

  service { 'ntp':
    ensure    => running,
    enable    => true,
    require   => Package['ntp'],
    subscribe => File['/etc/ntp.conf'],
  }
}

# vim: set ts=2 sw=2 sts=2 tw=0 et:
