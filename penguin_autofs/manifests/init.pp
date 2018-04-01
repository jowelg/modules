class penguin_autofs {

case $facts['os']['family'] {
 'RedHat': { $pkgnam='autofs' 
	     $automaster='auto.master'
	     $autohome='auto.home' }
'Solaris': { $pkgnam=[ 'SUNWatfsr', 'SUNWatfsu' ] 
             $sourcerepo='penguin_repos::solaris' 
	     $automaster='auto_master'
	     $autohome='auto_home' }
  default: { fail('Unsupported OS major release')}
}

Package { ensure => 'installed' }

package { $pkgnam:
 ensure => installed,
 require => Class[$sourcerepo],
 source => "/repos/solaris10dvd/Product",
 adminfile => "/repos/solaris10dvd/admin",
}

service { 'autofs':
 ensure => running,
 enable =>true,
}

file { "/etc/$automaster":
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => "puppet:///modules/penguin_autofs/$automaster",
  require => Package[$pkgnam],
  notify => Service[autofs],
}

file { "/etc/$autohome":
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => "puppet:///modules/penguin_autofs/$autohome",
  require => Package[$pkgnam],
  notify => Service[autofs],
}

}
