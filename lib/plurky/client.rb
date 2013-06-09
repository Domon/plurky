require 'faraday'
require 'simple_oauth'
require 'uri'
require 'plurky/api'
require 'plurky/configurable'

module Plurky
  # Wrapper for the Plurk API 2.0
  class Client
    include Plurky::API
    include Plurky::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Plurky::Client]
    def initialize(options = {})
      Plurky::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Plurky.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      request(:post, path, params)
    end

    private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

    # Perform an HTTP request
    def request(method, path, params = {})
      request_headers = {}
      if credentials?
        uri = URI(@endpoint) + path
        authorization = auth_header(method, uri, params)
        request_headers[:authorization] = authorization.to_s
      end

      response = connection.run_request(method, path, nil, request_headers) do |request|
        unless params.empty?
          case request.method
          when :post, :put
            request.body = params
          else
            request.params.update(params)
          end
        end
      end
      response.env
    end

    def auth_header(method, uri, params = {})
      signature_params = [:post, :put].include?(method) && params.values.any? { |value| value.respond_to?(:to_io) } ? {} : params
      SimpleOAuth::Header.new(method, uri, signature_params, credentials)
    end

  end
end
