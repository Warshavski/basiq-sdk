# frozen_string_literal: true

module Basiq
  # Basiq::Query
  #
  #   Used to build and execute request to the basiq API
  #
  class Query
    attr_reader :headers

    def initialize(endpoint, headers, parser, filter_builder = nil)
      @parser = parser
      @filter_builder = filter_builder || FilterBuilder.new

      @root_endpoint = endpoint
      @headers = headers
    end

    %i[eq gt gteq lt lteq].each do |method|
      # Filters
      #
      #   - "Equals" filter
      #   - "Greater than" filter
      #   - "Greater than or equal to" filter
      #   - "Less than" filter
      #   - "Less than or equal to" filter
      #
      # @param [String] field - The field to which the filter is applied
      # @param [String] value - The value to filter on
      #
      define_method(method) do |field, value|
        @filter_builder.public_send(method, field, value)

        self
      end
    end

    # "Between two values" filter - used for date range filtering.
    #
    # NOTE :  Values are inclusive.
    #
    # @param [String] field         - The field to which the filter is applied
    # @param [String] first_value   - The first value in the range to filter on
    # @param [String] second_value  - The last value in the range to filter on
    #
    # @return [Self]
    #
    def bt(field, first_value, second_value)
      @filter_builder.bt(field, first_value, second_value)

      self
    end

    # Retrieves the details of an existing resource.
    # You need only supply the resource unique identifier.
    #
    # @param [String] resource_id - Resource unique identifier
    #
    # @return [Basiq::Entities::Base]
    #
    def find_by_id(resource_id)
      endpoint = "/#{@root_endpoint}/#{resource_id}"

      perform_request!(:get, endpoint: endpoint)
    end

    # Retrieves and iterates through a collection of the basiq entities.
    #
    # Each entry in the array is a separate basiq entity object.
    #
    # @return [Basiq::Cursor]
    #
    def retrieve
      endpoint = @root_endpoint

      filters = @filter_builder.build
      if !filters.nil? && !filters.empty?
        endpoint = "#{@root_endpoint}?#{filters}"
      end

      Basiq::Cursor.new(endpoint) do |url|
        perform_request!(:get, endpoint: url)
      end
    end

    # Use this to create a new resource object.
    #
    # Returns the resource object if the update succeeded.
    # Returns an error if update parameters are invalid.
    #
    # @param [Hash] params - Particular resource object parameters
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Basiq::Entities::Base]
    #
    def create(params)
      perform_request!(:post, endpoint: @root_endpoint, body: params)
    end

    # Updates the specified resource object by setting the values of the parameters passed.
    # Any parameters not provided will be left unchanged.
    #
    # Returns the resource object if the update succeeded.
    # Returns an error if update parameters are invalid.
    #
    # @param [String] resource_id - Resource unique identifier
    # @param [Hash] params - Particular resource object parameters
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Basiq::Entities::Base]
    #
    def update(resource_id, params)
      endpoint = "/#{@root_endpoint}/#{resource_id}"

      perform_request!(:post, endpoint: endpoint, body: params)
    end

    # Permanently deletes a user along with all of their associated connection details.
    # You need only supply the unique user identifier that was returned upon user creation.
    #
    # Returns an empty body if the delete succeeded.
    # Otherwise, this call returns an error in the event of a failure.
    #
    # NOTE : Note that this action cannot be undone!
    #
    # @param [String] resource_id - Resource unique identifier
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [nil]
    #
    def delete(resource_id)
      endpoint = "/#{@root_endpoint}/#{resource_id}"

      perform_request!(:delete, endpoint: endpoint)
    end

    private

    def perform_request!(method, endpoint:, params: nil, body: nil)
      request = Basiq::Request.new(endpoint)

      opts = { headers: headers, params: params }

      opts[:body] = body unless body.nil?

      response = request.public_send(method, opts)

      @parser.parse(response.body)
    end
  end
end
