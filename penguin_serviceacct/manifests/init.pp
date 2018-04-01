class penguin_serviceacct {

case $facts['os']['family'] {
 'RedHat': { $homedir='/home' }
#'Solaris': { $homedir='/export/home' }
'Solaris': { $homedir='/home' }
  default: { fail('Unsupported OS major release')}
}

group {'ladmin':
        ensure => 'present',
        gid => '1000',
}

user {'ladmin':
        ensure => 'present',
        comment => 'ladmin',
        uid => '1000',
        gid => '1000',
        home => "${homedir}/ladmin",
        shell => '/bin/bash',
        password  => '$6$xfa4lAAAa3leQEK3$nM5alptNHyjqtBwrvKLcIZRBC5D7nh9O7p6gw0QGbmngheIs1UPyZUPMLScvczOTb5xYmwYN133V85PfN4N0L.',
}

file { "$homedir/ladmin":
        ensure => 'directory',
        owner => 'ladmin',
        group => 'ladmin',
	mode => '0750',
}

group {'foscam':
        ensure => 'present',
        gid => '1001',
}

user {'foscam':
        ensure => 'present',
        comment => 'foscam',
        uid => '1001',
        gid => '1001',
        home => "${homedir}/foscam",
        shell => '/bin/bash',
        password  => '$6$EKj9GvIP$R4rjzQdWbVVJQwVtQPPhnQmS.ICO59E3/4.LFAbs8.vnumLLz.Tp/JAWrToktEICc6.wfs7mAnoHa8/vtFgtZ.',
}

file { "$homedir/foscam":
        ensure => 'directory',
        owner => 'foscam',
        group => 'foscam',
	mode => '0750',
}

}
