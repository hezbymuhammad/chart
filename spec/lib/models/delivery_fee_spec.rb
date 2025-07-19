# frozen_string_literal: true

RSpec.describe Chart::Models::DeliveryFee do
  before(:each) do
    Chart::Models::Product.send(:instance_variable_set, :@store, [])
    Chart::Models::DeliveryFee.send(:instance_variable_set, :@store, [])
    Chart::Models::Offer.send(:instance_variable_set, :@store, [])
    Chart::Models::Basket.send(:instance_variable_set, :@store, [])
  end

  describe '#initialize' do
    it 'creates a delivery fee with the given attributes' do
      delivery_fee = Chart::Models::DeliveryFee.new(
        id: 1,
        name: 'Standard Delivery',
        price: 5.99,
        chart_price_threshold: 50.00
      )

      expect(delivery_fee.instance_variable_get(:@id)).to eq(1)
      expect(delivery_fee.instance_variable_get(:@name)).to eq('Standard Delivery')
      expect(delivery_fee.instance_variable_get(:@price)).to eq(5.99)
      expect(delivery_fee.instance_variable_get(:@chart_price_threshold)).to eq(50.00)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the delivery fee' do
      delivery_fee = Chart::Models::DeliveryFee.new(
        id: 1,
        name: 'Standard Delivery',
        price: 5.99,
        chart_price_threshold: 50.00
      )

      expect(delivery_fee.to_s).to eq('Standard Delivery - $5.99')
    end
  end

  describe '#apply' do
    it 'returns the delivery fee that meets the chart price threshold' do
      delivery_fee1 = Chart::Models::DeliveryFee.new(
        id: 1,
        name: 'Standard Delivery',
        price: 5.99,
        chart_price_threshold: 0.00
      )
      delivery_fee1.save

      delivery_fee2 = Chart::Models::DeliveryFee.new(
        id: 2,
        name: 'Express Delivery',
        price: 10.99,
        chart_price_threshold: 50.00
      )
      delivery_fee2.save

      delivery_fee3 = Chart::Models::DeliveryFee.new(
        id: 3,
        name: 'Priority Delivery',
        price: 15.99,
        chart_price_threshold: 100.00
      )
      delivery_fee3.save

      expect(Chart::Models::DeliveryFee.apply(30.00)).to eq(delivery_fee1)
    end
  end
end
