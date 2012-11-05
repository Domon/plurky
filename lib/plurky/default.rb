require 'plurky/configurable'

module Plurky
  module Default
    ENDPOINT = "http://www.plurk.com/"

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
      def options
        Hash[Plurky::Configurable.keys.map { |key| [key, send(key)] }]
      end

    end
  end
end
