# frozen_string_literal: true

module Chart
  module Initializers
    # Offer initializer class
    class Offer < Base
      def execute
        offer_data.each_with_index do |offer, index|
          offer_model = Chart::Models::Offer.new(
            id: index + 1,
            name: offer[:name],
            discount: offer[:discount],
            strategy: offer[:strategy],
            status: offer[:status]
          )
          offer_model.save

          product = Chart::Models::Product.select(id: offer[:product_code]).first
          if product
            product.offer = offer_model
            product.save
          end
        end
      end

      private

      def offer_data
        [
          {
            strategy: 'pair',
            name: 'Buy one red widget, get the second half price!',
            discount: 16.47,
            status: 'active',
            product_code: 'R01'
          }
        ]
      end
    end
  end
end
