require 'yaml'

module Maze
  class Config
    attr_reader :hash

    def initialize( args = {} )
      if File.exists?(args[:file])
        @hash = YAML.load_file(args[:file])
      else
        puts "#{options[:config]} not found!"
        exit
      end
    end

    def method_missing(key)
      @hash[key.to_s]
    end

  end
end
