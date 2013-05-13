require 'faraday'
require 'hashie/mash'

module Plurky
  module Response
    class Mashify < Faraday::Response::Middleware

      def parse(body)
        case body
        when Hash
          Hashie::Mash.new body
        when Array
          body.map { |item| item.is_a?(Hash) ? Hashie::Mash.new(item) : item }
        else
          body
        end
      end

      # Overrides Faraday::Response::Middleware#on_complete
      def on_complete(env)
        unless [204, 301, 302, 304].include?(env[:status])
          env[:body] = parse(env[:body])
        end
      end

    end
  end
end
