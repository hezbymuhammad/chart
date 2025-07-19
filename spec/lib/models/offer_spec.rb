# frozen_string_literal: true

RSpec.describe Chart::Models::Offer do
  describe '#initialize' do
    it 'creates an offer with the given attributes' do
      offer = Chart::Models::Offer.new(
        id: 1,
        name: 'Summer Sale',
        discount_rate: 20,
        status: 'active'
      )

      expect(offer.id).to eq(1)
      expect(offer.name).to eq('Summer Sale')
      expect(offer.instance_variable_get(:@discount_rate)).to eq(20)
      expect(offer.status).to eq('active')
    end
  end
end
