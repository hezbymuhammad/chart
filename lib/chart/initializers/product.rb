# frozen_string_literal: true

module Chart
  module Initializers
    # Product initializer class
    class Product < Base
      def execute
        products_data.each do |data|
          name, id, price = data
          product = Chart::Models::Product.new(id: id, name: name, price: price.to_f)
          product.save
        end
      end

      private

      def products_data
        [
          ['Red Widget', 'R01', '32.95'],
          ['Green Widget', 'G01', '24.95'],
          ['Blue Widget', 'B01', '7.95']
        ]
      end
    end
  end
end
