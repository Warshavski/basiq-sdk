# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Institution
    #
    #   The institution object represents a financial institution
    #   (such as a bank, credit union etc).
    #   You can use this object to obtain a list of supported institutions or
    #   to get general information about each institution.
    #
    class Institution < Base
      attr_accessor :id, :type, :links,
                    :name, :short_name, :country,
                    :institution_type, :service_type, :service_name, :tier,
                    :login_id_caption, :password_caption, :logo

      # @param [Hash] params - Institution attributes
      #
      # @option params [String] :id -
      #   A string that uniquely identifies the institution.
      #
      # @option params [String] :name -
      #   The full name of the institution.
      #
      # @option params [String] :short_name -
      #   Short name of institution.
      #
      # @option params [String] :institution_type -
      #   An enum identifying the institution type. Possible values include:
      #     - Bank
      #     - Bank (Foreign)
      #     - Test Bank
      #     - Credit Union
      #     - Financial Services
      #     - Superannuation
      #
      # @option params [String] :country -
      #   Country in which this institution operates.
      #   English short name used by ISO 3166/MA.
      #
      # @option params [String] :service_name -
      #   Name of the supported service (as defined by the institution).
      #
      # @option params [String] :service_type -
      #   An enum identifying the service type. Possible values include:
      #     - Personal Banking
      #     - Business Banking
      #     - Card Access
      #     - Test
      #
      # @option params [Hash] :logo -
      #   Object that contains main colors, and URLs of
      #   square and full institution logo image, returned in SVG format.
      #
      # @option params [String] :tier -
      #   Institution's tier - a representation of it's business and
      #   market share in the relevant country/region.
      #   Values range from 1 to 4. Tier 1 are Institutions with the
      #   highest impact on the market.
      #   For example, CBA is a Tier 1 Bank, Suncorp is a Tier 2 Bank, etc.
      #
      # @option params [String] :login_id_caption -
      #   Caption used by institution to request login id.
      #
      # @option params [String] :password_caption -
      #   Caption used by institution to request password.
      #
      def initialize(params)
        super(params)
      end

      def to_h
        {
          id: id,
          name: name,
          short_name: short_name,
          country: country,
          service_name: service_name,
          service_type: service_type,
          institution_type: institution_type,
          tier: tier,
          login_id_caption: login_id_caption,
          password_caption: password_caption,
          logo: logo
        }
      end
    end
  end
end

