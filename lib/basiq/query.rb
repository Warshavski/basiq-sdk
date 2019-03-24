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

      response = Basiq::Request.new(endpoint).get(headers: headers)

      @parser.parse(response.body)
    end

    # Use this collection to retrieve a list of institutions.
    # Each entry in the array is a separate institution object.
    #
    # @return [Array<Basiq::Entities::base]
    #
    def retrieve
      filters = @filter_builder.build

      endpoint = @root_endpoint
      endpoint = "#{@root_endpoint}?#{filters}" if filters.present?

      response = Basiq::Request.new(endpoint).get(headers: headers)

      @parser.parse(response.body)
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
      response = Basiq::Request
                 .new(@root_endpoint)
                 .post(body: params, headers: headers)

      @parser.parse(response.body)
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

      response = Basiq::Request
                 .new(endpoint)
                 .post(body: params, headers: headers)

      @parser.parse(response.body)
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

      Basiq::Request.new(endpoint).delete(headers: headers)
    end
  end
end
