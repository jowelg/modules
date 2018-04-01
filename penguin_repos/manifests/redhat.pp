class penguin_repos::redhat {

file { '/etc/yum.repos.d/ftp.repo':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'puppet:///modules/penguin_repos/ftp.repo',
 }

}
