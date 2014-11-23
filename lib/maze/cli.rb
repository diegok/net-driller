require 'thor'
require 'maze/config'

module Maze
  class CLI < Thor

    class_option :config, :aliases => ["-c"], :type => :string
    class_option :verbose, :type => :boolean

    def initialize(*args)
      super
      puts options[:config]
      @cfg = Maze::Config.new( :file => options[:config] )
    end

    desc 'up', 'Ensure tunnels are configured and working.'
    def up()
      puts "TODO: up command"
    end

    desc 'down', 'Ensure tunnels are removed and turned off.'
    def down()
      puts "TODO: down command"
    end

    desc 'restart', 'Same as calling down and then up.'
    def restart()
      puts "TODO: restart command"
    end

  end
end

