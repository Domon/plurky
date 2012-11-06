require 'plurky/configurable'
require 'plurky/response/parse_json'
require 'plurky/version'

module Plurky
  module Default
    ENDPOINT = 'http://www.plurk.com/'

    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "Plurky Ruby Gem #{Plurky::VERSION}"
      },
      :open_timeout => 5,
      :raw => true,
      :ssl => { :verify => false },
      :timeout => 10
    }

    MIDDLEWARE = Faraday::Builder.new(
      &Proc.new do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Plurky::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    )

    class << self

      # @return [String]
      def consumer_key
        ENV['PLURK_CONSUMER_KEY']
      end

      # @return [String]
      def consumer_secret
        ENV['PLURK_CONSUMER_SECRET']
      end

      # @return [String]
      def oauth_token
        ENV['PLURK_OAUTH_TOKEN']
      end

      # @return [String]
      def oauth_token_secret
        ENV['PLURK_OAUTH_TOKEN_SECRET']
      end

      # @return [String]
      def endpoint
        ENDPOINT
      end

      # @return [Hash]
      def connection_options
        CONNECTION_OPTIONS
      end

      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

      # @return [Hash]
      def options
        Hash[Plurky::Configurable.keys.map { |key| [key, send(key)] }]
      end

    end
  end
end
