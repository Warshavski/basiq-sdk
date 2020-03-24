# frozen_string_literal: true

module Basiq
  # Basiq::Cursor
  #
  #   Represents container for entities collection
  #
  class Cursor
    include Enumerable

    def initialize(endpoint, &block)
      @endpoint = endpoint
      @requester = block

      @collection = []
    end

    def each(start = 0)
      return to_enum(:each, start) unless block_given?

      Array(@collection[start..-1]).each { |element| yield(element) }

      if more_batches?
        start = [@collection.size, start].max

        fetch_batch

        each(start, &Proc.new)
      end
    end

    private

    def fetch_batch
      data = @requester.call(@endpoint)

      @collection += data[:entities]
      @endpoint = data.dig(:links, :next)
    end

    def more_batches?
      !@endpoint.nil?
    end
  end
end
