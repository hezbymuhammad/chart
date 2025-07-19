# frozen_string_literal: true

module Chart
  module Initializers
    class DeliveryFee < Base
      def execute
        delivery_data.each_with_index do |rule, index|
          delivery_fee = Chart::Models::DeliveryFee.new(
            id: index + 1,
            name: "Delivery Fee for orders over #{rule[:threshold]}",
            price: rule[:fee],
            chart_price_threshold: rule[:threshold]
          )
          delivery_fee.save
        end
      end

      private

      def delivery_data
        [
          { threshold: 90, fee: 0.00 },
          { threshold: 50, fee: 2.95 },
          { threshold: 0, fee: 4.95 }
        ]
      end
    end
  end
end
