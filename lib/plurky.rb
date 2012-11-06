require 'plurky/client'
require 'plurky/configurable'
require 'plurky/version'

module Plurky
  class << self
    include Plurky::Configurable

    # Delegate to a Plurky::Client
    #
    # @return [Plurky::Client]
    def client
      @client = Plurky::Client.new(options) unless defined?(@client) && @client.cache_key == options.hash
      @client
    end

    # Delegate to Plurky::Client
    #
    def respond_to?(method, include_private = false)
      client.respond_to?(method, include_private) || super(method, include_private)
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Plurky.setup
