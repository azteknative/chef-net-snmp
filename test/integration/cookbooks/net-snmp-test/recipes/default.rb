
include_recipe 'net-snmp'


case node['platform']
  when 'centos','redhat','fedora'
    package 'net-snmp-utils'
  when 'debian', 'ubuntu'
    package 'snmp'
end

