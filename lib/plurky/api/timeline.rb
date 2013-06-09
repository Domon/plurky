module Plurky
  module API
    module Timeline
      # Returns a status
      #
      # @see http://www.plurk.com/API#/APP/Timeline/getPlurk
      # @return [Hashie::Mash] The requested status.
      # @param id [Integer] A status ID.
      # @param options [Hash] A customizable set of options.
      # @example Return the status with the ID 1001647781
      #   Plurky.status(1001647781)
      def status(id, options = {})
        get("/APP/Timeline/getPlurk", options.merge(:plurk_id => id))
      end
    end
  end
end
