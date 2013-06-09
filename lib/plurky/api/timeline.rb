module Plurky
  module API
    module Timeline
      # Returns a status
      #
      # @see http://www.plurk.com/API#/APP/Timeline/getPlurk
      # @return [Hashie::Mash] The requested status.
      # @param id [Integer] A status ID.
      # @example Return the status with the ID 1001647781
      #   Plurky.status(1001647781)
      def status(id)
        object_from_response(:get, "/APP/Timeline/getPlurk", { :plurk_id => id }).plurk
      end

      private

      # @param method [Symbol]
      # @param url [String]
      # @param params [Hash]
      # @return [Hashie::Mash]
      def object_from_response(method, url, params = {})
        response = send(method, url, params)
        response[:body]
      end
    end
  end
end
