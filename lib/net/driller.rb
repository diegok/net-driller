require 'net/driller/config'
require 'net/driller/logger'
require 'net/driller/host'

module Net; class Driller

  attr_reader :config, :log, :hosts, :tunnel_range

  def initialize( args )
    @config       = Net::Driller::Config.new(args)
    @log          = Net::Driller::Logger.new(STDERR)
    @tunnel_range = @config.tunnel_range || tunnel_range_default

    load_hosts
  end

  def load_hosts
    @hosts = @config.hosts.map { |h| Net::Driller::Host.new(*h, log) }
  end

  def init_hosts
    @hosts.each do |host|
      host.connect
      host.setup
      # TODO: make driller aware of existing tunnels and routes so it can 
      # automagically calculate free ranges for drilling (see ensure_drill)
    end
  end

  def setup_tunnels
    all_hosts = @hosts.clone

    while source_host = all_hosts.shift
      all_hosts.each do |target_host|
        ensure_drilled source_host, target_host
      end
    end
  end

  def ensure_drilled host1, host2
    host1.set_tunnel_to host2
    host2.set_tunnel_to host1

    if host1.ping? host2 and host2.ping? host1
      @log.info "#{host1.name} and #{host2.name} are now connected!"
    else
      @log.error "#{host1.name} and #{host2.name} can't ping each other after setting up the tunnel!"
    end
  end

  private
  def tunnel_range_default
    @log.warn 'Using default tunnel range: 10.11.0.0/16'
    '10.11'
  end

end; end
