class penguin_nfs {

mount { "/myHome":
 device  => "emperor:/myHome",
 fstype  => "nfs",
 ensure  => "mounted",
 options => "defaults",
 atboot  => true,
 require => File["/myHome"],
}

file { "/myHome":
 ensure => directory,
# owner => 'root',
# group => 'root',
# mode => '0755',
}

}
