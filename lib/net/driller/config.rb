require 'yaml'

class Net::Driller::Config

    attr_reader :hash

    def initialize( args = { :file => 'drill.conf' } )
      if args[:file] && File.exists?(args[:file])
        @hash = YAML.load_file(args[:file])
      end
    end

    def method_missing(key)
      if @hash
        @hash[key.to_s]
      else
        puts "Config not found!"
        exit
      end
    end

end
