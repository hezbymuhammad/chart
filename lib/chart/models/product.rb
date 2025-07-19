# frozen_string_literal: true

module Chart
  # Models module representation of data model
  module Models
    # Product model represents a product in the chart.
    class Product < Base
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
