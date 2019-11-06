module Plurky
  module API
    module Timeline
      # Returns a status
      #
      # @see https://www.plurk.com/API#/APP/Timeline/getPlurk
      # @return [Hashie::Mash] The requested status.
      # @param id [Integer] A status ID.
      # @param options [Hash] A customizable set of options.
      # @example Return the status with the ID 1001647781
      #   Plurky.status(1001647781)
      def status(id, options = {})
        get("/APP/Timeline/getPlurk", options.merge(:plurk_id => id))
      end

      # Updates the authenticating user's status
      #
      # @see https://www.plurk.com/API#/APP/Timeline/plurkAdd
      # @return [Hashie::Mash] The created status.
      # @param content [String] The content of the status update, up to 140 characters.
      # @param qualifier [String] The qualifier of the status update.
      # @param options [Hash] A customizable set of options.
      # @example Update the authenticating user's status
      #   Plurky.update("I'm plurking with Plurky!", "says")
      def update(content, qualifier, options = {})
        post("/APP/Timeline/plurkAdd", options.merge(:content => content, :qualifier => qualifier))
      end
    end
  end
end
