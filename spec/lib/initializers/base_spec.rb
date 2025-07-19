# frozen_string_literal: true

RSpec.describe Chart::Initializers::Base do
  class TestInitializer < Chart::Initializers::Base
  end

  describe '#execute' do
    it 'raises NotImplementedError' do
      initializer = TestInitializer.new
      expect do
        initializer.execute
      end.to raise_error(NotImplementedError,
                         "#{TestInitializer}#execute must be implemented")
    end
  end
end
