# frozen_string_literal: true

module Chart
  describe '.VERSION' do
    it 'return correct version' do
      expect(Chart::VERSION).to eq('0.0.0')
    end
  end
end
