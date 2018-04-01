class penguin_ldap {

if $facts['os']['family'] == 'RedHat' {

package {'openldap-clients':
        ensure => 'installed',
}

package {'nss-pam-ldapd':
        ensure => 'installed',
}

package {'pam':
        ensure => 'installed',
}

file { '/etc/openldap/ldap.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ldap/ldap.conf',
  require => Package['openldap-clients'],
   }

file { '/etc/nsswitch.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ldap/nsswitch.conf',
   }

service { 'nslcd':
 ensure => running,
 enable => true,
}

file { '/etc/nslcd.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0600',
  source  => 'puppet:///modules/penguin_ldap/nslcd.conf',
  notify => Service[nslcd],
   }

file { '/etc/pam.d/system-auth-ac':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ldap/system-auth-ac',
   }

file { '/etc/pam.d/password-auth-ac':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ldap/password-auth-ac',
   }

file { '/etc/pam.d/sshd':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_ldap/sshd',
   }


}
}
