class penguin_repos {

case $facts['os']['family'] {
 'RedHat': { include penguin_repos::redhat }
'Solaris': { include penguin_repos::solaris }
  default: { fail('Unsupported OS major release')}
}

}
