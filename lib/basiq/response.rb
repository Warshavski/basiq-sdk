# frozen_string_literal: true

module Basiq
  # Basiq::Response
  #
  #   Used to represent basiq api response
  #     (raw body and headers information)
  #
  class Response
    attr_accessor :body, :headers

    def initialize(body: {}, headers: {})
      @body = body
      @headers = headers
    end
  end
end
