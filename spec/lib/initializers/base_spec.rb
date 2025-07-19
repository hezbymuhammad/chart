# frozen_string_literal: true

class TestInitializer < Chart::Initializers::Base
end

RSpec.describe Chart::Initializers::Base do
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
