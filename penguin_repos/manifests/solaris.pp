class penguin_repos::solaris { 

mount { "/repos":
 device  => "emperor:/var/ftp/pub",
 fstype  => "nfs",
 ensure  => "mounted",
 options => "defaults",
 atboot  => false,
 require => File["/repos"],
}

file { "/repos":
 ensure => directory,
 owner => 'root',
 group => 'root',
 mode => '0755',
}

}
