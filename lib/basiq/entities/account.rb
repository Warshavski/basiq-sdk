# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Account
    #
    #   The account object represents an account held with a
    #   financial institution (e.g. a savings account).
    #   You can use this object to retrieve specific account details such as
    #   the account number, balance and available funds.
    #
    class Account < Base
      attr_accessor :id, :type, :links, :self,
                    :account_no, :name, :currency,
                    :balance, :available_funds, :last_updated,
                    :class, :status, :institution, :connection, :transactions

      # @param [Hash] params
      #
      # @option params [String] :id -
      #   Uniquely identifies the account.
      #
      # @option params [String] :account_no -
      #   Full account number.
      #
      # @option params [String] :name -
      #   Account name as defined by institution or user.
      #
      # @option params [String] :currency -
      #   The currency the funds are stored in, using ISO 4217 standard.
      #
      # @option params [String] :balance -
      #   Amount of funds in the account right now - excluding any pending transactions.
      #   For a credit card this would be zero or the minus amount spent.
      #
      # @option params [String] :available_funds -
      #   Funds that are available to an account holder for withdrawal or other use.
      #   This may include funds from an overdraft facility or line of credit,
      #   as well as funds classified as the available balance,
      #   such as from cleared and existing deposits.
      #
      # @option params [String, DateTime] :last_updated -
      #   Timestamp of last update, UTC, RFC 3339 format e.g. "2017-09-28T13:39:33.144Z"
      #
      # @option params [Hash] :class -
      #   Identifies the account type and product as defined by institution.
      #
      #   Possible values for account type are:
      #
      #     - credit-card - a credit card account.
      #     - foreign - a foreign cash account e.g. travel card.
      #     - insurance - an insurance account.
      #     - investment - a investment account.
      #     - loan - a loan (e.g. personal or business loan).
      #     - mortgage - a home loan.
      #     - savings - savings account.
      #     - term-deposit - a term deposit account.
      #     - transaction - a keycard or chequing account.
      #     - unknown
      #
      #   product - A property of class object. Product name as defined by institution.
      #   meta - A property of class object. Meta data related to account type.
      #
      #   For account type mortgagemeta data include:
      #
      #     - accountNumber - full account number.
      #     - interestType - loan interest rate type fixed rate or variable
      #     - repaymentType - loan repayment type interest only or interest and principal
      #     - repaymentFrequency - loan repayment frequency weekly, fortnightly or monthly
      #     - nextInstalmentDate - next loan instalment date
      #     - instalmentAmount - next loan instalment amount
      #     - interestRate - current loan percentage interest rate - 4.8% p.a expressed as "4.08"
      #     - endDate - loan maturity date
      #     - fee - loan service fees "500.00" or text such as "waived"
      #     - availableRedraw - loan paid off that is available for redraw (variable loans only)
      #     - offsetAccountNumber - account linked to loan account, balance is offset against loan.
      #
      # @option params [String] :status -
      #   Indicates the account status. Possible values include:
      #
      #     - available newest account data is available.
      #     - unavailable account information is no longer available
      #
      # @option params [String] :institution -
      #   The id of the institution resource the account originated from.
      #
      # @option params [String] :connection -
      #   The id of the connection resource that was used to retrieve the account.
      #
      def initialize(params)
        super(params)
      end
    end
  end
end
