# frozen_string_literal: true

module Basiq
  # Basiq::Request
  #
  #   [DESCRIPTION]
  #
  class Request
    TIMEOUT = 60
    OPEN_TIMEOUT = 60
    API_ENDPOINT = 'https://au-api.basiq.io'

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
      request.headers['basiq-version'] = '2.0'
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
      return nil if response.body.nil? || response.body.empty?

      begin
        headers = response.headers
        body = MultiJson.load(response.body, symbolize_keys: true)

        Response.new(headers: headers, body: body)
      rescue MultiJson::ParseError
        error = ServiceError.new(
          "Unparseable response: #{response.body}",
          title: 'UNPARSEABLE_RESPONSE', status_code: 500
        )

        raise error
      end
    end

    def handle_error(error)
      error_params = {}

      begin
        if error.is_a?(Faraday::Error::ClientError) && error.response
          error_params[:status_code] = error.response[:status]
          error_params[:raw_body] = error.response[:body]

          parsed_response = MultiJson.load(error.response[:body])

          if parsed_response
            error_params[:body] = parsed_response

            if parsed_response['title']
              error_params[:title] = parsed_response['title']
            end

            if parsed_response['detail']
              error_params[:detail] = parsed_response['detail']
            end
          end

        end
      rescue MultiJson::ParseError
      end

      error_to_raise = ServiceError.new(error.message, error_params)

      raise error_to_raise
    end
  end
end
