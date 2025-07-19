# frozen_string_literal: true

module Chart
  module Models
    # DeliveryFee model represents a delivery fee in the chart.
    class DeliveryFee < Base
      attr_accessor :id, :name, :price, :chart_price_threshold

      def initialize(id:, name:, price:, chart_price_threshold:)
        @id = id
        @name = name
        @price = price
        @chart_price_threshold = chart_price_threshold
      end

      def to_s
        "#{name} - $#{format('%.2f', price)}"
      end

      def self.apply(chart_price)
        all.select do |delivery_fee|
          delivery_fee.chart_price_threshold <= chart_price
        end.max_by(&:chart_price_threshold)
      end
    end
  end
end
