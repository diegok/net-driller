require 'thor'
require 'net/driller'

module Net; class Driller

  class CLI < Thor

    class_option :config, :aliases => ["-c"], :type => :string
    class_option :verbose, :type => :boolean

    def initialize(*args)
      super
      @app = Net::Driller.new( :file => options[:config] )
    end

    desc 'test', 'Check tunnels are configured and working.'
    def test
    end

    desc 'up', 'Ensure tunnels are configured and working.'
    def up
      @app.init_hosts
      @app.setup_tunnels
    end

    desc 'down', 'Ensure tunnels are removed and turned off.'
    def down
    end

    desc 'restart', 'Same as calling down and then up.'
    def restart
    end

  end

end; end
