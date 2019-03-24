# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Transaction
    #
    #   A transaction object is created whenever money is debited or credited from a particular account.
    #
    #   NOTE : Note that when a connection is refreshed pending transactions will
    #          receive new id's, whilst posted transactions will
    #          receive the same id's as before the refresh.
    #
    #          Find out more about pending transaction:
    #          http://docs.basiq.io/the-basiq-platform/what-is-a-pending-transaction
    #
    class Transaction < Base
      attr_accessor :id, :type, :links,
                    :status, :description,
                    :post_date, :transaction_date,
                    :amount, :balance, :bank_category,
                    :account, :institution, :connection, :direction,
                    :class, :sub_class
    end

    # @param [Hash] params
    #
    # @option params [String] :id -
    #   Uniquely identifies the transaction for the connection.
    #
    # @option params [String] :status -
    #   Identifies if a transaction is pending or posted.
    #   A pending transaction is an approved debit or credit transaction that
    #   has not been fully processed yet (i.e. has not been posted).
    #
    # @option params [String] :description -
    #   The transaction description as submitted by the institution.
    #
    # @option params [String, DateTime] :post_date -
    #   Date the transaction was posted as provided by the institution
    #   (this is the same date that appears on a bank statement).
    #   This value is null if the record is pending. e.g. "2017-11-10T21:46:44Z" or 2017-11-10T00:00:00Z
    #
    # @option params [String, DateTime] :transaction_date -
    #   Date that the user executed the transaction as provided by the istitution.
    #   Note that not all transactions provide this value (varies by institution) e.g. "2017-11-10T00:00:00Z"
    #
    # @option params [String] :amount -
    #   Transaction amount. Outgoing funds are expressed as negative values.
    #
    # @option params [String] :balance -
    #   Value of the account balance at time the transaction was completed.
    #
    # @option params [String] :bank_category -
    #   Category as defined by the institution itself.
    #   Note that not all institutions define this category.
    #
    # @option params [String] :direction -
    #   Identifies if the transaction is of debit or credit type.
    #
    # @option params [String] :class -
    #   Describes the class(type) of transaction.
    #   Possible values depend on the direction field, and include:
    #
    #   Debit Classes:
    #
    #     - bank-fee - a fee incurred by the user from their bank e.g. ATM withdrawal fee.
    #     - payment - payment made to a merchant.
    #     - cash-withdrawal - funds withdrawn via atm facility.
    #     - transfer - funds transferred to an account.
    #
    #   Credit Classes:
    #
    #     - refund - funds returned due to refund.
    #     - direct-credit - funds deposited into an account.
    #     - interest - interest earned.
    #     - transfer - funds received from an account.
    #
    # @option params [Hash] :sub_class -
    #   Attribute includes a code and title property.
    #   The subClass attribute will only return values for payment transactions (i.e. will be empty for all others)
    #
    # @option params [String] :account -
    #   The id of the account resource the transaction belongs to.
    #
    # @option params [String] :institution -
    #   The id of the institution resource the transaction originated from.
    #
    # @option params [String] :connection -
    #   The id of the connection resource that was used to retrieve the transaction.
    #
    # @option params [Hash] :links -
    #   A links object containing related objects
    #
    def initialize(params)
      super(params)
    end
  end
end
