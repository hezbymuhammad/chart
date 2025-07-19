# frozen_string_literal: true

module Chart
  module Store
    # Module to define a has_many relationship
    module HasMany
      def has_many(association_name, klass)
        define_method(association_name) do
          init = []
          init.define_singleton_method(:<<) do |instance|
            raise ArgumentError, "Expected #{klass}, got #{instance.class}" unless instance.is_a?(klass)
            push(instance) unless include?(instance)
          end
          instance_variable_get("@#{association_name}") || instance_variable_set("@#{association_name}", init)
        end
      end
    end
  end
end
