class penguin_test (
String $localsetting = undef,
){

file { '/tmp/sampletemplate':
 ensure => present,
 content => epp('penguin_test/ipinfo.epp',
		{ localsetting => $localsetting,}),

}

$message = hiera('FROMHIERA')
notify { $message: }

file { '/tmp/samplehiera':
 ensure => present,
 content => epp('penguin_test/ipinfo.epp',
               { localsetting => $message, }),
}

physical_volume { '/dev/sdb':
  ensure => present,
}

volume_group { 'datavg':
  ensure           => present,
  physical_volumes => '/dev/sdb',
}

logical_volume { 'testlv':
  ensure       => present,
  volume_group => 'datavg',
#  size         => '2G',
  initial_size => '2G',
}

filesystem { '/dev/datavg/testlv':
  ensure  => present,
  fs_type => 'ext4',
  options => '-b 4096',
}

mount { '/test':
 ensure => mounted,
 device => '/dev/datavg/testlv', 
 name => '/test',
 fstype => 'ext4',
 atboot => true,
 require => File["/test"],
}

file { "/test":
 ensure => directory,
 owner => 'root',
 group => 'root',
 mode => '0755',
}

}
