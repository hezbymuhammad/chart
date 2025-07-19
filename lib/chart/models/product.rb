# frozen_string_literal: true

module Chart
  module Models
    # Product model represents a product in the chart.
    class Product < Base
      extend Chart::Store::HasOne

      has_one :offer, Chart::Models::Offer

      attr_accessor :id, :name, :price

      def initialize(id:, name:, price:)
        @id = id
        @name = name
        @price = price
      end

      def to_s
        "#{name} (#{id}) - $#{format('%.2f', price)}"
      end
    end
  end
end
