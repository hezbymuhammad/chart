# frozen_string_literal: true

RSpec.describe Chart::Models::Basket do
  describe '#initialize' do
    it 'creates a basket with the given product and quantity' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
      basket = Chart::Models::Basket.new(product: product, quantity: 2)

      expect(basket.product).to eq(product)
      expect(basket.quantity).to eq(2)
    end
  end

  describe '#calculate_price' do
    context 'when there is no offer' do
      it 'calculates the price based on quantity and product price' do
        product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
        basket = Chart::Models::Basket.new(product: product, quantity: 2)

        basket.calculate_price

        expect(basket.price).to eq(200.00)
      end
    end

    context 'when there is an active offer' do
      it 'applies the discount based on the offer strategy' do
        product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
        offer = Chart::Models::Offer.new(
          id: 1,
          name: '10% Off',
          discount: 10,
          strategy: 'percentage',
          status: 'active'
        )

        product.offer = offer

        basket = Chart::Models::Basket.new(product: product, quantity: 2)
        basket.calculate_price

        expect(basket.price).to eq(180.00)
      end

      it 'does not apply the discount if the offer is inactive' do
        product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
        offer = Chart::Models::Offer.new(
          id: 1,
          name: '10% Off',
          discount: 10,
          strategy: 'percentage',
          status: 'inactive'
        )

        product.offer = offer

        basket = Chart::Models::Basket.new(product: product, quantity: 2)
        basket.calculate_price

        expect(basket.price).to eq(200.00)
      end
    end
  end

  describe '#save' do
    it 'calculates the price before saving' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
      basket = Chart::Models::Basket.new(product: product, quantity: 2)

      basket.save

      expect(basket.price).to eq(200.00)
    end
  end
end
