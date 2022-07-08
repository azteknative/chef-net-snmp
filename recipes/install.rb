
case node['platform']
  when 'centos','redhat','fedora'
    package 'net-snmp'
  when 'debian', 'ubuntu'
    include_recipe 'apt'
    package 'snmpd'
end

