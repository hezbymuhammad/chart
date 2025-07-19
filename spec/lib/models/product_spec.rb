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

      expect(product.to_s).to eq('Test Product (1) - $19.99 - offer: none')
    end

    it 'returns a string representation of the product and offer' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 19.99)
      offer = Chart::Models::Offer.new(
        id: 1,
        name: 'Summer Sale',
        discount: 20,
        strategy: 'fixed',
        status: 'active'
      )
      product.offer = offer

      expect(product.to_s).to eq('Test Product (1) - $19.99 - offer: Summer Sale')
    end
  end
end
