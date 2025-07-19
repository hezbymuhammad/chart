# frozen_string_literal: true

module Chart
  module Store
    # Module to define a has_one relationship
    module HasOne
      def has_one(association_name, klass)
        define_method(association_name) do
          instance_variable_get("@#{association_name}")
        end

        define_method("#{association_name}=") do |instance|
          raise ArgumentError, "Expected #{klass}, got #{instance.class}" unless instance.is_a?(klass)
          instance_variable_set("@#{association_name}", instance)
        end
      end
    end
  end
end
