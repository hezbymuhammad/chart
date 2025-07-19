# frozen_string_literal: true

module Chart
  module Store
    # Module to define a has_one relationship
    module HasOne
      def has_one(association_name)
        define_method(association_name) do
          instance_variable_get("@#{association_name}")
        end

        define_method("#{association_name}=") do |instance|
          instance_variable_set("@#{association_name}", instance)
        end
      end
    end
  end
end
