# frozen_string_literal: true

module Chart
  module Models
    # Offer model representation of product offer
    class Offer < Base
      attr_accessor :id, :name, :value, :status

      def initialize(id:, name:, discount_rate:, status:)
        @id = id
        @name = name
        @discount_rate = discount_rate
        @status = status
      end
    end
  end
end
