# frozen_string_literal: true

module Basiq
  # Basiq::FilterBuilder
  #
  #   Used to build filters query.
  #
  #   Filtering a collection resource is conducted via the
  #   filter query parameter using the following notation:
  #
  #     ?filter=[property].[condition]([value])
  #
  #
  #   NOTE : All filter values should be URL encoded!
  #          Examples have not url encoded the filters.
  #          You will need to ensure that the filter values are
  #          url encoded before calling the resource.
  #
  class FilterBuilder
    attr_accessor :filters

    def initialize
      @filters = []
    end

    # "Equals" filter
    #
    # @param [String] field - The field to which the filter is applied
    # @param [String] value - The value to filter on
    #
    # Example : ?filter=account.id.eq('s55bf3')
    #
    # @return [Self]
    #
    def eq(field, value)
      tap { filters << "#{field}.eq('#{value}')" }
    end

    # "Greater than" filter
    #
    # @param [String] field - The field to which the filter is applied
    # @param [String] value - The value to filter on
    #
    # Example : ?filter=transaction.postDate.gt('2018-01-28')
    #
    # @return [Self]
    #
    def gt(field, value)
      tap { filters << "#{field}.gt('#{value}')" }
    end

    # "Greater than or equal to" filter
    #
    # @param [String] field - The field to which the filter is applied
    # @param [String] value - The value to filter on
    #
    # Example : ?filter=transaction.postDate.gteq('2018-01-28')
    #
    # @return [Self]
    #
    def gteq(field, value)
      tap { filters << "#{field}.gteq('#{value}')" }
    end

    # "Less than" filter
    #
    # @param [String] field - The field to which the filter is applied
    # @param [String] value - The value to filter on
    #
    # Example : ?filter=transaction.postDate.lt('2018-01-28')
    #
    # @return [Self]
    #
    def lt(field, value)
      tap { filters << "#{field}.lt('#{value}')" }
    end

    # "Less than or equal to" filter
    #
    # @param [String] field - The field to which the filter is applied
    # @param [String] value - The value to filter on
    #
    # Example : ?filter=transaction.postDate.lteq('2018-01-28')
    #
    # @return [Self]
    #
    def lteq(field, value)
      tap { filters << "#{field}.lteq('#{value}')" }
    end

    # "Between two values" filter - used for date range filtering.
    #
    # NOTE :  Values are inclusive.
    #
    # @param [String] field         - The field to which the filter is applied
    # @param [String] first_value   - The first value in the range to filter on
    # @param [String] second_value  - The last value in the range to filter on
    #
    # Example : ?filter=transaction.postDate.bt('2017-09-28','2018-01-30').
    #
    # @return [Self]
    #
    def bt(field, first_value, second_value)
      tap { filters << "#{field}.bt('#{first_value}', '#{second_value}')" }
    end

    # Build filter expression and return query string
    #
    # Example : ?filter=transaction.postDate.bt('2018-01-28','2018-02-27'),account.id.eq('aef3g')
    #
    # @return [String]
    #
    def build
      "filter=#{filters.join(',')}"
    end
  end
end
