# frozen_string_literal: true

module Chart
  # Models module representation of data model
  module Models
    # Base class for all models in the chart.
    class Base
      extend Chart::Store::Base

      def save
        self.class.save(self)
      end
    end
  end
end
