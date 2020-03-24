# frozen_string_literal: true

module Basiq
  # Basiq::Parser
  #
  #   Used to transform(convert) raw data from API response to
  #   the Basiq entities models
  #
  class Parser
    ENTITIES = {
      'account' => Basiq::Entities::Account,
      'transaction' => Basiq::Entities::Transaction,
      'user' => Basiq::Entities::User,
      'connection' => Basiq::Entities::Connection,
      'institution' => Basiq::Entities::Institution,
      'image' => Basiq::Entities::Image,
      'job' => Basiq::Entities::Job
    }.freeze

    # Transform raw response data to the Basiq entity
    #   (may return array if list request was made)
    #
    # @param [Hash] data - Raw data from the API request
    #
    # @return [Hash, Array<Basiq::Entities::Base>, Basiq::Entities::Base]
    #
    def parse(data)
      transformed_data = transform_keys(data)

      convert(transformed_data, top_level: true)
    end

    private

    def convert(data, top_level: false)
      if data[:type] == 'list'
        convert_to_list(data, top_level)
      else
        convert_to_entity(data)
      end
    end

    def convert_to_list(raw_data, top_level)
      entities = raw_data[:data].compact.map { |obj| convert_to_entity(obj) }

      if top_level
        { links: raw_data[:links], entities: entities }
      else
        entities
      end
    end

    def convert_to_entity(data)
      attributes = data.each_with_object({}) do |(key, value), hash|
        hash[key] = entity?(value, key) ? convert(value) : value
      end

      ENTITIES[data[:type]].new(attributes)
    end

    def entity?(value, key)
      value.is_a?(Hash) && value.key?(:type) && key != :class
    end

    def transform_keys(data)
      deep_transform_keys(data) { |key| underscore(key.to_s).to_sym }
    end

    def deep_transform_keys(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = deep_transform_keys(value, &block)
        end
      when Array
        object.map { |e| deep_transform_keys(e, &block) }
      else
        object
      end
    end

    def underscore(camel_cased_word)
      camel_cased_word.gsub(/::/, '/')
                      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                      .tr('-', '_')
                      .downcase
    end
  end
end
