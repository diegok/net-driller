require 'maze/config'
require 'maze/logger'

module Maze
  class App

    attr_reader :config
    attr_reader :log

    def initialize( args )
      @config = Maze::Config.new(args)
      @log    = Maze::Logger.new(STDERR)
    end

    def say( what )
      log.info what
    end

  end
end
