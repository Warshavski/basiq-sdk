# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::User
    #
    #   The user object represents an end-user of your application.
    #   This object encapsulates all of the financial details of an
    #   individual (such as list of accounts and transactions) along with
    #   the relationships that they hold with each institution (i.e. connections).
    #
    #   Use this object to keep your list of users in sync with the Basiq server.
    #   Once a user ceases to use your application,
    #   it is strongly recommended that the user object is deleted.
    #
    class User < Base
      attr_accessor :id, :type, :links, :email, :mobile, :name, :connections

      # @param [Hash] params - User attributes
      #
      # @option params [String] :id -
      #   A string that uniquely identifies the user.
      #
      # @option params [String] :email -
      #   The end-users email address.
      #
      # @option params [String] :mobile -
      #   The end-users mobile number.
      #
      def initialize(params)
        super(params)
      end
    end
  end
end
