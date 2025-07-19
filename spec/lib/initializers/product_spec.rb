# frozen_string_literal: true

RSpec.describe Chart::Initializers::Product do
  describe '#execute' do
    it 'initializes product data and saves them' do
      initializer = Chart::Initializers::Product.new
      initializer.execute

      expect(Chart::Models::Product.all.count).to eq(3)

      product1 = Chart::Models::Product.select(id: 'R01').first
      expect(product1.name).to eq('Red Widget')
      expect(product1.price).to eq(32.95)

      product2 = Chart::Models::Product.select(id: 'G01').first
      expect(product2.name).to eq('Green Widget')
      expect(product2.price).to eq(24.95)

      product3 = Chart::Models::Product.select(id: 'B01').first
      expect(product3.name).to eq('Blue Widget')
      expect(product3.price).to eq(7.95)
    end
  end
end
