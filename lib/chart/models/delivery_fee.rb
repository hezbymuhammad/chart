# frozen_string_literal: true

module Chart
  # Models module representation of data model
  module Models
    class DeliveryFee < Base
      attr_accessor :id, :name, :price, :chart_price_threshold

      def initialize(id:, name:, price:, chart_price_threshold:)
        @id = id
        @name = name
        @price = price
        @chart_price_threshold = chart_price_threshold
      end

      def self.apply(chart_price)
        all.select do |delivery_fee|
          delivery_fee.chart_price_threshold <= chart_price
        end.sort_by { |delivery_fee| delivery_fee.chart_price_threshold }.last
      end
    end
  end
end
