# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # Parse the response. build with object
    module Response
      module_function

      def dynamic_attributes(object, attribute_names, response)
        attribute_names.each do |attribute_name|
          attribute_value = field_value(attribute_name, response)

          # Manually creates methods for both getter and setter and then
          #   sends a message to the new setter with the attribute_value
          object.class.send(:define_method, "#{attribute_name}=".to_sym) do |value|
            instance_variable_set('@' + attribute_name, value)
          end

          object.class.send(:define_method, attribute_name.to_sym) do
            instance_variable_get('@' + attribute_name.to_s)
          end

          object.send("#{attribute_name}=".to_sym, attribute_value)
        end

        object
      end

      private

      def field_value(name, data)
        value = data.dig(name)

        return value if value.nil? || value.is_a?(String)
        return value.collect { |e| e.dig('value') } if value.is_a?(Array) && value[0].is_a?(Hash) && value[0].keys.include?('value')
        return value.dig('value') if value.is_a?(Hash) && value.keys.include?('value')

        value
      end
    end
  end
end
