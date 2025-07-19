# frozen_string_literal: true

RSpec.describe Chart::Models::DeliveryFee do
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

  describe '#apply' do
    it 'returns the delivery fee that meets the chart price threshold' do
      delivery_fee1 = Chart::Models::DeliveryFee.new(
        id: 1,
        name: 'Standard Delivery',
        price: 5.99,
        chart_price_threshold: 50.00
      )
      delivery_fee1.save

      delivery_fee2 = Chart::Models::DeliveryFee.new(
        id: 2,
        name: 'Express Delivery',
        price: 10.99,
        chart_price_threshold: 100.00
      )
      delivery_fee2.save

      delivery_fee3 = Chart::Models::DeliveryFee.new(
        id: 3,
        name: 'Priority Delivery',
        price: 15.99,
        chart_price_threshold: 200.00
      )
      delivery_fee3.save

      expect(Chart::Models::DeliveryFee.apply(60.00)).to eq(delivery_fee1)
      expect(Chart::Models::DeliveryFee.apply(150.00)).to eq(delivery_fee2)
      expect(Chart::Models::DeliveryFee.apply(250.00)).to eq(delivery_fee3)
    end
  end
end
