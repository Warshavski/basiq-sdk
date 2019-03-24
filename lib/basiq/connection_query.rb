# frozen_string_literal: true

require 'basiq/query'

module Basiq
  # Basiq::ConnectionQuery
  #
  #   Used to build and execute request to the basiq API
  #     (connections specific operations)
  #
  class ConnectionQuery < Query
    def initialize(endpoint, headers, parser, filter_builder = nil)
      super(endpoint, headers, parser, filter_builder)
    end

    # Use this to create a new connection object.
    #
    # Returns the job object if the update succeeded.
    # Returns an error if update parameters are invalid.
    #
    # @param [Hash] params - User credentials for the connected institution
    #
    # @option params [String] :login_id -
    #   The users institution login ID
    #
    # @option params [String] :password -
    #   The users institution password
    #
    # @option params [String] :security_code -
    #   (conditional) User's institution security code.
    #   Mandatory if required by institution's login process
    #
    # @option params [String] :secondary_login_id -
    #   (conditional) User's institution secondary login id.
    #   Mandatory if required by institution's login process
    #
    # @option params [String] :institution_id -
    #   A string that uniquely identifies the institution.
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Basiq::Entities::Job]
    #
    def create(params)
      body = compose_body(params)
      response = Basiq::Request
                 .new(@root_endpoint)
                 .post(body: body, headers: headers)

      @parser.parse(response.body)
    end

    # Updates the specified connection object by setting the values of the parameters passed.
    # Any parameters not provided will be left unchanged.
    #
    # Returns the job object if the update succeeded.
    # Returns an error if update parameters are invalid.
    #
    # @param [String] connection_id - Uniq connection identifier
    #
    # @param [Hash] params - for the connected institution
    #
    # @option params [String] :login_id -
    #   The users institution login ID
    #
    # @option params [String] :password -
    #   The users institution password
    #
    # @option params [String] :security_code -
    #   (conditional) User's institution security code.
    #   Mandatory if required by institution's login process
    #
    # @option params [String] :secondary_login_id -
    #   (conditional) User's institution secondary login id.
    #   Mandatory if required by institution's login process
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Basiq::Entities::Job]
    #
    def update(connection_id, params)
      endpoint = "/#{@root_endpoint}/#{connection_id}"
      body = compose_body(params).without('institution')

      response = Basiq::Request
                 .new(endpoint)
                 .post(body: body, headers: headers)

      @parser.parse(response.body)
    end

    # Use this to retrieve the latest financial data.
    # Similar to when a connection is first created, the refresh resource will
    # initiate the following series of steps to retrieve the latest
    # financial data from the target institution:
    #
    #   1. verify-credentials   - The server will attempt to authenticate with
    #                             the target institution using the supplied credentials.
    #
    #   2. retrieve-accounts    - The server will retrieve the complete list of
    #                             accounts and their details
    #                             e.g. account number, name and balances.
    #
    #   3. retrieve-transaction - The server will fetch the associated
    #                             transactions for each of the accounts.
    #
    # @param [String] connection_id - The identifier of the connection to be refreshed.
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Basiq::Entities::Job]
    #
    def refresh(connection_id)
      endpoint = "/#{@root_endpoint}/#{connection_id}/refresh"

      response = Basiq::Request.new(endpoint).post(headers: headers)

      @parser.parse(response.body)
    end

    # Use this to refresh of all connections.
    # Check how to refresh a connection for more details.
    #
    # @raise [Basiq::ServiceError]
    #
    # @return [Array<Basiq::Entities::Job>]
    #
    def refresh_all
      endpoint = "/#{@root_endpoint}/refresh"

      response = Basiq::Request.new(endpoint).post(headers: headers)

      @parser.parse(response.body)
    end

    private

    def compose_body(params)
      {
        'loginId' => params[:login_id],
        'password' => params[:password],
        'securityCode' => params[:security_code],
        'secondary_login_id' => params[:secondary_login_id],
        'institution' => {
          'id' => params[:institution_id]
        }
      }
    end
  end
end
