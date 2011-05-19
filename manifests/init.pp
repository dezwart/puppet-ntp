# ntp service
#
# == Parameters
#
# [*servers*]
#   List of upstream NTP servers.
#
# == Variables
#
# == Examples
#
#    class { 'ntp':
#        servers => [ 'ntp0.example.com', 'ntp1.example.com' ],
#    }
#
class ntp( $servers = undef ) {
	package { 'ntp':
		ensure	=> installed,
	}

	file { '/etc/ntp.conf':
		ensure	=> file,
		owner	=> root,
		group	=> root,
		mode	=> '0644',
		content	=> template('ntp/ntp.conf.erb'),
		require => Package['ntp'],
	}

	service { 'ntp':
		ensure		=> running,
		enable		=> true,
		require		=> Package['ntp'],
		subscribe	=> File['/etc/ntp.conf'],
	}
}
