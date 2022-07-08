#
# Cookbook Name:: net-snmp
# Recipe:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
  service_name 'snmpd'
  supports :restart => true
  action[:enable, :start]
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
