# frozen_string_literal: true

module Chart
  # Initializers module provides functionality for initializing chart data
  module Initializers
    # Base class for initializers
    class Base
      def execute
        raise NotImplementedError, "#{self.class}#execute must be implemented"
      end
    end
  end
end
