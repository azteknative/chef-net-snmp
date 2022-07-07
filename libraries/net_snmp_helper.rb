module NetSnmp
  module Helper
    def snmp_v2c_source_ip
      node['snmp_v2c']['source_ip'].nil? ? "" : node['snmp_v2c']['source_ip']
    end
  end
end
