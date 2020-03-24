# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::List
    #
    #   Represents container for entities collection
    #
    class List
      include Enumerable

      def initialize(collection = nil, links = nil)
        @collection = collection || []
        @links = links || {}
      end

      def each
        return to_enum(:each, start) unless block_given?

        Array(@collection[start..-1]).each do |element|
          yield(element)
        end

        unless last?
          start = [@collection.size, start].max

          fetch_next_page

          each(start, &Proc.new)
        end
      end

      def method_missing(method, *args, &block)
        if @list.respond_to? method
          @list.public_send(method, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        @list.respond_to?(method, include_private) || super
      end
    end
  end
end
