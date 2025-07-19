# frozen_string_literal: true

module Chart
  module Store
    # Base module for storing instances of a class
    module Base
      def store
        @store ||= []
      end

      def save(instance)
        store << instance unless store.include?(instance)
      end

      def all
        store
      end

      def reset
        store.clear
      end

      def select(attributes = {})
        store.select do |instance|
          attributes.all? { |key, value| instance.send(key) == value }
        end
      end

      def self.extended(base)
        base.instance_variable_set(:@store, [])
      end
    end
  end
end
