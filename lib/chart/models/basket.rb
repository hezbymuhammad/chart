# frozen_string_literal: true

module Chart
  module Models
    # Basket model representation of the basket / chart
    class Basket < Base
      extend Chart::Store::HasOne

      has_one :product, Chart::Models::Product
      has_one :offer, Chart::Models::Offer

      attr_accessor :quantity, :price

      def initialize(product:, quantity:)
        @product = product
        @quantity = quantity
      end

      def self.calculate_total_price
        all.sum(&:price)
      end

      # assume checkout is successful
      def self.checkout
        all.each(&:save)
        reset
      end

      def calculate_price
        @price = product.price * quantity

        offer = product.offer
        return if offer.nil?

        discount = offer.get_discount_for(self)
        @price -= discount if discount && discount > 0
      end

      def save
        calculate_price
        super
      end

      def to_s
        "#{product.name} - quantity #{quantity} - total $#{format('%.2f', price || 0)}"
      end
    end
  end
end
