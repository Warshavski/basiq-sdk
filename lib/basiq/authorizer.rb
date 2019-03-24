# frozen_string_literal: true

module Basiq
  # Basiq::Authorizer
  #
  #   When working with Basiq APIs application will need to complete the
  #   authentication process first before you can access any of the available resources.
  #
  #   The authentication process is fairly straight forward,
  #   and simply requires you to exchange your API key for a token.
  #
  #   Once you obtain the token, you can call any of the available API services by
  #   simply including the token in the Authorization header of each request.
  #
  #   NOTE : Tokens have a short lifespan and as such should not be stored permanently.
  #          Once a token has expired your application will need to reauthenticate.
  #
  class Authorizer

    # @param [String] api_key -
    #   (optional) API key for your application(via the Developer Dashboard)
    #
    def initialize(api_key = nil)
      @api_key = api_key || ENV['BASIQ_API_KEY']

      raise ArgumentError, 'Invalid API key' if @api_key.nil?
    end

    # Retrieves the access token
    #
    def obtain_token
      headers = {
        'Authorization' => "Basic #{@api_key}",
        'Content-Type' => 'application/x-www-form-urlencoded'
      }

      response = Basiq::Request.new('token').post(headers: headers)

      return nil if response.nil?

      parse_token(response.body)
    end

    private

    def parse_token(data)
      params = {
        token: data[:access_token],
        type: data[:token_type],
        expires_in: data[:expires_in]
      }

      Basiq::Entities::AccessToken.new(params)
    end
  end
end
