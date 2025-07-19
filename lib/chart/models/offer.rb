# frozen_string_literal: true

module Chart
  module Models
    # Offer model representation of product offer
    class Offer < Base
      attr_accessor :id, :name, :discount, :strategy, :status

      def initialize(id:, name:, discount:, strategy:, status:)
        @id = id
        @name = name
        @discount = discount
        @strategy = strategy
        @status = status
      end

      def get_discount_for(basket)
        return unless status == 'active'
        return unless validate_strategy_for?(basket)

        calculate_discount_for(basket)
      end

      def to_s
        "#{name} - #{strategy} discount - $#{format('%.2f', discount)} - #{status}"
      end

      private

      def validate_strategy_for?(basket)
        case @strategy
        when 'pair'
          basket.quantity >= 2
        when 'fixed', 'percentage'
          true
        else
          false
        end
      end

      def calculate_discount_for(basket)
        case @strategy
        when 'pair'
          mod = basket.quantity % 2
          discount * (basket.quantity - mod) / 2
        when 'fixed'
          discount
        when 'percentage'
          basket.price * (discount / 100.0)
        else
          0
        end
      end
    end
  end
end
