
describe service('snmpd') do
  it { should be_running }
end

describe file('/etc/snmp/snmpd.conf') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0600' }
  its('content') { should match /rocommunity  example-community/ }
end

describe command('snmpwalk -v 2c -c example-community localhost') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /Example User <email@example\.com>/ }
end

