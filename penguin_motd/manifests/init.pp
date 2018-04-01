class penguin_motd {

case $facts['os']['family'] {
 'RedHat': { $pkgnam='cowsay' 
  	     $motdfile='/etc/profile.d/motd.sh' 
	     $motdsource='puppet:///modules/penguin_motd/motd.sh' 
      	 	package { $pkgnam:
		 ensure => installed,
		}
           }
'Solaris': { $motdfile='/etc/motd' 
	     $motdsource='puppet:///modules/penguin_motd/motd_solaris' }
  default: { fail('Unsupported OS major release')}
}


file { $motdfile:
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => $motdsource,
}

}
