# frozen_string_literal: true

RSpec.describe Chart::Models::Basket do
  before(:each) do
    Chart::Models::Product.send(:instance_variable_set, :@store, [])
    Chart::Models::DeliveryFee.send(:instance_variable_set, :@store, [])
    Chart::Models::Offer.send(:instance_variable_set, :@store, [])
    Chart::Models::Basket.send(:instance_variable_set, :@store, [])
  end

  describe '#initialize' do
    it 'creates a basket with the given product and quantity' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
      basket = Chart::Models::Basket.new(product: product, quantity: 2)

      expect(basket.product).to eq(product)
      expect(basket.quantity).to eq(2)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the delivery fee' do
      product = Chart::Models::Product.new(id: 1, name: 'Product 1', price: 100.00)
      basket = Chart::Models::Basket.new(product: product, quantity: 2)

      basket.save

      expect(basket.to_s).to eq('Product 1 - quantity 2 - total $200.00')
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

  describe '.calculate_total_price' do
    it 'calculates the total price of all baskets' do
      delivery_fee1 = Chart::Models::DeliveryFee.new(
        id: 1,
        name: 'Standard Delivery',
        price: 5.00,
        chart_price_threshold: 0.00
      )
      delivery_fee1.save

      product1 = Chart::Models::Product.new(id: 1, name: 'Product 1', price: 100.00)
      product2 = Chart::Models::Product.new(id: 2, name: 'Product 2', price: 150.00)

      basket1 = Chart::Models::Basket.new(product: product1, quantity: 2)
      basket2 = Chart::Models::Basket.new(product: product2, quantity: 1)

      basket1.save
      basket2.save

      total_price = Chart::Models::Basket.calculate_total_price
      expect(total_price).to eq(355.00)
    end
  end

  describe '.checkout' do
    it 'saves all baskets and resets the store' do
      product = Chart::Models::Product.new(id: 1, name: 'Test Product', price: 100.00)
      basket = Chart::Models::Basket.new(product: product, quantity: 2)
      basket.save

      expect { Chart::Models::Basket.checkout }.to change { Chart::Models::Basket.all.count }.by(-1)

      expect(Chart::Models::Basket.all).to be_empty
    end
  end

  describe '.add' do
    before(:each) do
      product = Chart::Models::Product.new(id: 'R01', name: 'Red Widget', price: 32.95)
      product_with_offer = Chart::Models::Product.new(id: 'R02', name: 'Red Widget', price: 30)
      offer = Chart::Models::Offer.new(
        id: 1,
        name: 'Summer Sale',
        discount: 20,
        strategy: 'fixed',
        status: 'active'
      )
      product_with_offer.offer = offer
      offer.save
      product.save
      product_with_offer.save
    end

    it 'adds a new product to the basket' do
      basket = Chart::Models::Basket.add('R01', 2)

      expect(basket.product.id).to eq('R01')
      expect(basket.quantity).to eq(2)
    end

    it 'increases the quantity of an existing basket' do
      basket = Chart::Models::Basket.add('R01', 2)
      expect(basket.quantity).to eq(2)

      basket = Chart::Models::Basket.add('R01', 3)
      expect(basket.quantity).to eq(5)
    end

    it 'apply offer of an existing basket' do
      basket = Chart::Models::Basket.add('R02', 1)
      expect(basket.price).to eq(10)
    end

    it 'raises an error if the product is not found' do
      expect do
        Chart::Models::Basket.add('INVALID_CODE')
      end.to raise_error(ArgumentError, 'Product not found')
    end
  end
end
