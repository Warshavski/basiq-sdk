# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Base
    #
    #   [DESCRIPTION]
    #
    class Base
      # @param [Hash] attributes - (optional, nil) Attributes in hash
      #
      # @raise [ArgumentError]
      # @raise [UnknownAttributeError]
      #
      # @yield [self] Invokes the block with a instance
      #
      def initialize(attributes = nil)
        assign_attributes(attributes) if attributes

        yield self if block_given?
      end

      private

      def assign_attributes(new_attributes)
        unless new_attributes.is_a?(Hash)
          raise ArgumentError, 'Attributes must be a Hash'
        end

        return if new_attributes.nil? || new_attributes.empty?

        attributes = stringify_keys(new_attributes)
        attributes.each { |k, v| _assign_attribute(k, v) }
      end

      def stringify_keys(hash)
        transform_keys(hash) { |key| key.to_s }
      end

      def transform_keys(hash)
        hash.each_with_object({}) do |(key, value), result|
          result[yield(key)] = value
        end
      end

      def _assign_attribute(attr_name, attr_value)
        return unless respond_to?("#{attr_name}=")

        public_send("#{attr_name}=", attr_value)
      end
    end
  end
end
