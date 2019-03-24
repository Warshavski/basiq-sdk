# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Image
    #
    #   Represents Image object
    #
    class Image < Base
      attr_accessor :type, :colors, :links

      def initialize(params)
        super(params)
      end
    end
  end
end
