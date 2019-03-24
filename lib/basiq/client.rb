# frozen_string_literal: true

module Basiq
  # Basiq::Client
  #
  #   Client to interact with BASIQ API
  #
  class Client
    # @param [String] api_key -
    #   Unique API key grabbed for your application(via the Developer Dashboard)
    #
    def initialize(api_key)
      @api_key = api_key
      @access_token = nil
    end

    # Check client authorization
    #   (access token validity)
    #
    def authorized?
      !@access_token.nil? && @access_token.valid?
    end

    # Perform client authorization
    #   (obtain or renew access token)
    #
    def authorize!
      @access_token = Authorizer.new(@api_key).obtain_token
    end

    # Get accounts query to perform operations related to the accounts endpoint
    #
    def accounts(user_id)
      build_query("users/#{user_id}/accounts")
    end

    # Get connections query to perform operations related to the connections endpoint
    #
    def connections(user_id)
      endpoint = "users/#{user_id}/connections"

      Basiq::ConnectionQuery.new(endpoint, headers, parser)
    end

    # Get transaction query to perform operations related to the transaction endpoint
    #
    def transactions(user_id)
      build_query("users/#{user_id}/transactions")
    end

    # Get jobs query to perform operations related to the jobs endpoint
    #
    def jobs
      build_query('jobs')
    end

    # Get user query to perform operations related to the users endpoint
    #
    def users
      build_query('users')
    end

    # Get institutions query to perform operations related to the institutions endpoint
    #
    def institutions
      build_query('institutions')
    end

    private

    def build_query(endpoint)
      Basiq::Query.new(endpoint, headers, parser)
    end

    def headers
      { 'Authorization' => "Bearer #{@access_token.token}" }
    end

    def parser
      Basiq::Parser.new
    end
  end
end
