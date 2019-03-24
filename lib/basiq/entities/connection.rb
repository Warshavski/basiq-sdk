# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Connection
    #
    #   The connection object is created whenever a user links their
    #   financial institution with your app.
    #   Once a connection is successfully created - you can use it to obtain the
    #   user's latest financial data i.e. accounts and transactions.
    #   After a connection is successfully established, you can fetch
    #   data created after this point by refreshing the connection.
    #   This process ensures on-demand data syncronization between your system
    #   and Institution itself.
    #
    class Connection < Base
      attr_accessor :id, :links, :type,
                    :status, :last_used, :login_id,
                    :password, :security_code, :secondary_login_id,
                    :accounts, :institution

      # @param [Hash] params
      #
      # @option params [String] :id -
      #   A string that uniquely identifies the user connection.
      #
      # @option params [String] :login_id -
      #   User's institution login ID. This value cannot be read.
      #
      # @option params [String] :password -
      #   User's institution password. This value cannot be read.
      #
      # @option params [String] :security_code -
      #   (conditional)User's institution security code.
      #   This value cannot be read.
      #
      # @option params [String] :secondary_login_id -
      #   (conditional)User's institution secondary login id.
      #   This value cannot be read.
      #
      # @option params [String] :status -
      #   Indicates the connection status.
      #   Possible values include:
      #
      #     - active the connection is valid (is working!)
      #     - invalid the connection is no longer valid and requires the user to update their logon details
      #
      # @option params [String, DateTime] :last_used -
      #   UTC Date and Time of when the connection was last used, in RFC 3339 format.
      #
      # @option params [Basiq::Entities::Institution] :institution -
      #   The institution the connection relates to.
      #
      # @option params [Array<Basiq::Entities::Accounts>] :accounts -
      #   User's accounts in this institution.
      #
      #
      def initialize(params)
        super(params)
      end

      def to_h
        {
          id: id,
          status: status,
          last_used: last_used
        }
      end
    end
  end
end
