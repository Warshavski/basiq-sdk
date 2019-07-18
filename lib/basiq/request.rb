# frozen_string_literal: true

module Basiq
  # Basiq::Request
  #
  #   Used to make requests and parse response from BASIQ API
  #
  class Request
    TIMEOUT = 60
    OPEN_TIMEOUT = 60
    API_ENDPOINT = 'https://au-api.basiq.io'
    API_VERSION = '2.0'

    def initialize(endpoint)
      @endpoint = endpoint
    end

    def post(params: nil, headers: nil, body: nil)
      response = rest_client.post(@endpoint) do |request|
        configure_request(
          request: request,
          params: params,
          headers: headers,
          body: MultiJson.dump(body)
        )
      end
      parse_response(response)
    rescue StandardError => e
      handle_error(e)
    end

    def get(params: nil, headers: nil)
      response = rest_client.get(@endpoint) do |request|
        configure_request(request: request, params: params, headers: headers)
      end
      parse_response(response)
    rescue StandardError => e
      handle_error(e)
    end

    def delete(params: nil, headers: nil)
      response = rest_client.delete(@endpoint) do |request|
        configure_request(request: request, params: params, headers: headers)
      end
      parse_response(response)
    rescue StandardError => e
      handle_error(e)
    end

    private

    def configure_request(request: nil, params: nil, headers: nil, body: nil)
      return unless request

      request.params.merge!(params) if params

      request.headers['Content-Type'] = 'application/json'
      request.headers['basiq-version'] = API_VERSION
      request.headers.merge!(headers) if headers

      request.body = body if body

      request.options.timeout = TIMEOUT
      request.options.open_timeout = OPEN_TIMEOUT
    end

    def rest_client
      Faraday.new(API_ENDPOINT, ssl: { version: 'TLSv1_2' }) do |faraday|
        faraday.response :raise_error
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def parse_response(response)
      return nil if empty_response?(response)

      begin
        headers, body = prepare_response(response)

        Response.new(headers: headers, body: body)
      rescue MultiJson::ParseError
        error = ServiceError.new(
          "Unparseable response: #{response.body}",
          title: 'UNPARSEABLE_RESPONSE', status_code: 500
        )

        raise error
      end
    end

    def empty_response?(response)
      response.body.nil? || response.body.empty?
    end

    def prepare_response(response)
      headers = response.headers
      body = MultiJson.load(response.body, symbolize_keys: true)

      [headers, body]
    end

    def handle_error(error)
      error_params = parsable_error?(error) ? parse_error(error) : {}

      error_to_raise = ServiceError.new(error.message, error_params)

      raise error_to_raise
    end

    def parsable_error?(error)
      error.is_a?(Faraday::Error::ClientError) && error.response
    end

    def parse_error(error)
      error_params = {
        status_code: error.response[:status],
        raw_body: error.response[:body]
      }

      begin
        parsed_response = MultiJson.load(error.response[:body])

        if parsed_response
          error_params[:correlation_id] = parsed_response['correlationId']
          error_params[:data] = parsed_response['data']
        end
      rescue MultiJson::ParseError
      end

      error_params
    end
  end
end
