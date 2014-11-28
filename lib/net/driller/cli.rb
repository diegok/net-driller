require 'thor'
require 'net/driller'

class Net::Driller
#class Driller

  class CLI < Thor

    class_option :config, :aliases => ["-c"], :type => :string
    class_option :verbose, :type => :boolean

    def initialize(*args)
      super
      @app = Net::Driller.new( :file => options[:config] )
    end

    desc 'test', 'Check tunnels are configured and working.'
    def test
      @app.say 'Un log'
      @app.say 'Otro log'
      @app.log.error 'OMG!'
    end

    desc 'up', 'Ensure tunnels are configured and working.'
    def up
      @app.say "TODO: up command"
    end

    desc 'down', 'Ensure tunnels are removed and turned off.'
    def down
      @app.say "TODO: down command"
    end

    desc 'restart', 'Same as calling down and then up.'
    def restart
      @app.say "TODO: restart command"
    end

  end

end
#end

