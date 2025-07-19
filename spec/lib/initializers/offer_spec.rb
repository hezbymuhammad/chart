# frozen_string_literal: true

RSpec.describe Chart::Initializers::Offer do
  describe '#execute' do
    before do
      # Clear the store before each test
      Chart::Models::Offer.send(:instance_variable_set, :@store, [])
    end

    it 'initializes offer data and saves them' do
      initializer = Chart::Initializers::Offer.new
      initializer.execute

      # Check that 1 offer is saved
      expect(Chart::Models::Offer.all.count).to eq(1)

      # Check the details of the offer
      offer = Chart::Models::Offer.select(id: 1).first
      expect(offer.name).to eq('Buy one red widget, get the second half price!')
      expect(offer.discount).to eq(16.47)
      expect(offer.strategy).to eq('pair')
      expect(offer.status).to eq('active')
    end
  end
end
