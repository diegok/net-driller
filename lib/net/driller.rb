require 'net/driller/config'
require 'net/driller/logger'

class Net::Driller

  attr_reader :config
  attr_reader :log

  def initialize( args )
    @config = Net::Driller::Config.new(args)
    @log    = Net::Driller::Logger.new(STDERR)
  end

  def say( what )
    log.info what
  end

end
