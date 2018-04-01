class penguin_ntp {

case $facts['os']['family'] {
 'RedHat': { $ntpfile='/etc/ntp.conf'
	     $pkgnam='ntp'  
	     $ntpsvc='ntpd' }
'Solaris': { $ntpfile='/etc/inet/ntp.conf'
             $pkgnam=[ 'SUNWntpu', 'SUNWntpr' ]
	     $ntpsvc='ntp' 
             $sourcerepo='penguin_repos::solaris' } 
  default: { fail('Unsupported OS major release')}
}

Package { ensure => 'installed' }

package { $pkgnam: 
 ensure => installed,
 require => Class[$sourcerepo],
 source => "/repos/solaris10dvd/Product",
 adminfile => "/repos/solaris10dvd/admin",
}

service { $ntpsvc:
 ensure => running,
 enable => true,
}

file { $ntpfile:
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ntp/ntp.conf',
  require => Package[$pkgnam],
  notify => Service[$ntpsvc],
}

}
