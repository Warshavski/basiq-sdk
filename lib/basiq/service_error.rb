# frozen_string_literal: true

module Basiq
  # Basiq::ServiceError
  #
  #   Used to represent an error that may occur when performing a request to the basiq API
  #
  class ServiceError < StandardError
    attr_reader :correlation_id, :data, :raw_body, :status_code

    # @param [String] message - (optional, '') Message to describe error
    # @param [Hash] params - (optional, {}) Additional error information
    #
    # @option params [String] :correlation_id -
    #   A unique identifier for this particular occurrence of the problem.
    #
    # @option params [String] :data -
    #   A JSON formatted error object that provides more details about the specifics of the error
    #
    # @option params [String] :raw_body -
    #   Raw body from response
    #
    # @option params [String] :status_code  -
    #   Http status code
    #
    def initialize(message = '', params = {})
      @correlation_id = params[:correlation_id]
      @data           = params[:data]
      @raw_body       = params[:raw_body]
      @status_code    = params[:status_code]

      super(message)
    end

    def to_s
      "#{super} #{instance_variables_to_s}"
    end

    private

    def instance_variables_to_s
      %i[correlation_id data raw_body status_code].map do |attr|
        attr_value = send(attr)

        "@#{attr}=#{attr_value.inspect}"
      end.join(', ')
    end
  end
end
