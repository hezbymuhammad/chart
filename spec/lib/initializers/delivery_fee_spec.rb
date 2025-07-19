# frozen_string_literal: true

RSpec.describe Chart::Initializers::DeliveryFee do
  describe '#execute' do
    it 'initializes delivery fee data and saves them' do
      initializer = Chart::Initializers::DeliveryFee.new
      initializer.execute

      expect(Chart::Models::DeliveryFee.all.count).to eq(3)

      fee1 = Chart::Models::DeliveryFee.select(id: 1).first
      expect(fee1.name).to eq('Delivery Fee for orders over 90')
      expect(fee1.price).to eq(0)

      fee2 = Chart::Models::DeliveryFee.select(id: 2).first
      expect(fee2.name).to eq('Delivery Fee for orders over 50')
      expect(fee2.price).to eq(2.95)

      fee3 = Chart::Models::DeliveryFee.select(id: 3).first
      expect(fee3.name).to eq('Delivery Fee for orders over 0')
      expect(fee3.price).to eq(4.95)
    end
  end
end
