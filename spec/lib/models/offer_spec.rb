# frozen_string_literal: true

RSpec.describe Chart::Models::Offer do
  describe '#initialize' do
    it 'creates an offer with the given attributes' do
      offer = Chart::Models::Offer.new(
        id: 1,
        name: 'Summer Sale',
        discount: 20,
        strategy: 'fixed',
        status: 'active'
      )

      expect(offer.id).to eq(1)
      expect(offer.name).to eq('Summer Sale')
      expect(offer.instance_variable_get(:@discount)).to eq(20)
      expect(offer.status).to eq('active')
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the offer' do
      offer = Chart::Models::Offer.new(
        id: 1,
        name: 'Summer Sale',
        discount: 20,
        strategy: 'fixed',
        status: 'active'
      )

      expect(offer.to_s).to eq('Summer Sale - fixed discount - $20.00 - active')
    end
  end

  describe '#get_discount_for' do
    let(:basket) { double('Basket', quantity: 2, price: 100.00) }

    context 'when the offer is active' do
      it 'calculates discount for fixed strategy' do
        offer = Chart::Models::Offer.new(
          id: 1,
          name: 'Flat Discount',
          discount: 15,
          strategy: 'fixed',
          status: 'active'
        )

        discount = offer.get_discount_for(basket)
        expect(discount).to eq(15.0) # Fixed discount
      end

      it 'calculates discount for percentage strategy' do
        offer = Chart::Models::Offer.new(
          id: 2,
          name: '10% Off',
          discount: 10,
          strategy: 'percentage',
          status: 'active'
        )

        discount = offer.get_discount_for(basket)
        expect(discount).to eq(10.0) # 10% of 100.00
      end

      it 'calculates discount for pair strategy' do
        offer = Chart::Models::Offer.new(
          id: 3,
          name: 'Buy One Get One',
          discount: 5,
          strategy: 'pair',
          status: 'active'
        )

        allow(basket).to receive(:quantity).and_return(2)
        discount = offer.get_discount_for(basket)
        expect(discount).to eq(5.0) # 5 discount for 2 items
      end

      it 'returns correct discount for pair strategy if quantity is odd' do
        offer = Chart::Models::Offer.new(
          id: 4,
          name: 'Buy One Get One',
          discount: 5,
          strategy: 'pair',
          status: 'active'
        )

        allow(basket).to receive(:quantity).and_return(3)
        discount = offer.get_discount_for(basket)
        expect(discount).to eq(5)
      end

      it 'returns nil for pair strategy if quantity is odd' do
        offer = Chart::Models::Offer.new(
          id: 4,
          name: 'Buy One Get One',
          discount: 5,
          strategy: 'pair',
          status: 'active'
        )

        allow(basket).to receive(:quantity).and_return(1)
        discount = offer.get_discount_for(basket)
        expect(discount).to be_nil
      end
    end

    context 'when the offer is inactive' do
      it 'returns nil' do
        offer = Chart::Models::Offer.new(
          id: 5,
          name: 'Inactive Offer',
          discount: 20,
          strategy: 'percentage',
          status: 'inactive'
        )

        discount = offer.get_discount_for(basket)
        expect(discount).to be_nil
      end
    end

    context 'when the strategy is not valid' do
      it 'returns nil' do
        offer = Chart::Models::Offer.new(
          id: 6,
          name: 'Invalid Strategy',
          discount: 20,
          strategy: 'invalid',
          status: 'active'
        )

        discount = offer.get_discount_for(basket)
        expect(discount).to be_nil
      end
    end
  end
end
