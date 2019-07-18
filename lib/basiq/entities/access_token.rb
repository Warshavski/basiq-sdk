# frozen_string_literal: true

require 'basiq/entities/base'

module Basiq
  module Entities
    # Basiq::Entities::AccessToken
    #
    #   This access token is the key to making successful requests to the Basiq API.
    #   You will need to include this access token in the header when
    #   requesting any of the secured resources as follows:
    #
    #   # => Authorization: Bearer [token]
    #
    class AccessToken < Base
      attr_accessor :token, :type, :expires_in

      # @param [Hash] params -
      #   Params required for token initialization
      #
      # @option params [String] :token -
      #   The generated access token.
      #
      # @option params [String] :type -
      #   Token authorization type. This value will always be "Bearer".
      #
      # @option params [Integer] :expires_in -
      #   The number of seconds left before the token becomes invalid.
      #
      def initialize(params)
        @current_session_ts = Time.now.utc

        super(params)
      end

      # Check token validity(expired or not)
      #
      # @return [Boolean]
      #
      def valid?
        (Time.now.utc - @current_session_ts).to_i < expires_in
      end
    end
  end
end
