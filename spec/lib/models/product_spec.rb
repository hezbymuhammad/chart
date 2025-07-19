# frozen_string_literal: true

RSpec.describe Chart::Models::Product do
  describe '#initialize' do
    it 'creates a product with the given attributes' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 19.99)

      expect(product.id).to eq(1)
      expect(product.name).to eq('Test Product')
      expect(product.price).to eq(19.99)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the product' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 19.99)

      expect(product.to_s).to eq('Test Product (1) - $19.99')
    end
  end
end
