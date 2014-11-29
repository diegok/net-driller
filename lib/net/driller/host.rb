require 'net/ssh'

module Net; class Driller; class Host

  @@attr_required = [ :name, :fqdn, :public_ip, :local_range, :local_netmask ]
  @@attr_optional = [ :local_ip ]
  
  attr_reader *[ @@attr_required, @@attr_optional ].flatten

  def initialize(hostname, config, log)
    config['name'] = hostname
    @log           = log

    @@attr_required.map {|a| a.to_s }.each do |r_attr|
      if config[r_attr] and !config[r_attr].empty?
        instance_variable_set("@#{r_attr}", config[r_attr])
      else
        raise "Missing required attribute '#{r_attr}' on host #{hostname}"
      end
    end

    @@attr_optional.map {|a| a.to_s }.each do |o_attr|
      instance_variable_set("@#{o_attr}", config[o_attr]) if config[o_attr]
    end

    @connect_ip = local_ip || public_ip
  end

  def connect
    @connection = Net::SSH.start(@connect_ip, 'root') # rescue raise "Coudn't connect to host '#{name}'"
  end

  def setup
    # Install gre module always
    @connection.exec! 'modprobe ip_gre'

    unless file_exists? '/etc/init.d/driller'
      # TODO: create an init file
      @log.info 'No init file, creating one'
    end

    unless dir_exists? '/etc/driller/driller.conf.d'
      # TODO: create an init file
      @log.info 'No config directory, creating one'
      @connection.exec! 'mkdir -p /etc/driller/driller.conf.d'
    end
  end

  def set_tunnel_to remote
    @log.info "Connecting #{name} -> #{remote.name}"
    # @connection.exec! "ip tunnel add drill_#{remote.name} mode gre remote #{remote.public_ip} local #{public_ip} ttl 255"
    # @connection.exec! "ip link set drill_#{remote.name} up"
    # @connection.exec! "ip addr add #{tunnel_ip}/24 dev drill_#{remote.name}"
    #                                      ^ TODO 

    # @connection.exec! "route add -net #{remote.localrange} netmask #{server.netmask} gw drill_#{remote.name}"
  end

  def ping? remote
    true
  end

  def file_exists? file
    @connection.exec! "if `test -f #{file}`; then echo yes; else echo no; fi" == "yes"
  end

  def dir_exists? dir
    @connection.exec! "if `test -d #{dir}`; then echo yes; else echo no; fi" == "yes"
  end

end; end; end
