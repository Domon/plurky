require 'plurky/default'

module Plurky
  module Configurable
    attr_writer :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret

    class << self
      def keys
        @keys ||= [
          :consumer_key,
          :consumer_secret,
          :oauth_token,
          :oauth_token_secret,
          :endpoint,
          :connection_options,
          :middleware
        ]
      end
    end

    # Allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    def reset!
      Plurky::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Plurky::Default.options[key])
      end
      self
    end
    alias setup reset!

    private

    # @return [Hash]
    def credentials
      {
        :consumer_key    => @consumer_key,
        :consumer_secret => @consumer_secret,
        :token           => @oauth_token,
        :token_secret    => @oauth_token_secret
      }
    end

  end
end
