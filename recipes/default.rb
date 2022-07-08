#
# Cookbook Name:: net-snmp
# Recipe:: default
#
Chef::Resource::Template.include NetSnmp::Helper

case node['platform']
  when 'CentOS','RedHat','Fedora'
  package 'net-snmp'
end

package 'net-snmp' do
  action :install
end

service 'snmpd' do
  supports :restart => true
  action [ :enable, :start ]
end

directory '/etc/snmp' do
  action :create
  owner 'root'
  group 'root'
  mode 0750
end

template '/etc/snmp/snmpd.conf' do
  source 'snmpd.conf.erb'
  variables ({
    community_string: node['snmp_v2c']['community_string'],
    source_ip: snmp_v2c_source_ip,
    syslocation: node['snmp_v2c']['syslocation'],
    syscontact: node['snmp_v2c']['syscontact'],
    mountpoints: node['snmp_v2c']['mountpoints']
  })
  notifies :restart, resources(:service => 'snmpd'), :immediately
end
