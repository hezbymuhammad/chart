# frozen_string_literal: true

module Chart
  module Initializers
    class Offer < Base
      def execute
        offer_data.each_with_index do |offer, index|
          delivery_fee = Chart::Models::Offer.new(
            id: index + 1,
            name: offer[:name],
            discount: offer[:discount],
            strategy: offer[:strategy],
            status: offer[:status]
          )
          delivery_fee.save
        end
      end

      private

      def offer_data
        [
          {
            strategy: 'pair',
            name: 'Buy one red widget, get the second half price!',
            discount: 16.47,
            status: 'active'
          }
        ]
      end
    end
  end
end
