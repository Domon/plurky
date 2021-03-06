require 'faraday'
require 'multi_json'

module Plurky
  module Response
    class ParseJson < Faraday::Response::Middleware

      def parse(body)
        case body
        when /\A^\s*$\z/, nil
          nil
        else
          MultiJson.load(body, :symbolize_keys => true)
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
