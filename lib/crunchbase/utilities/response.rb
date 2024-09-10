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
          dynamic_define_method(object, attribute_name, attribute_value)
        end

        [attribute_names & special_attributes].flatten.each do |attribute_name|
          attribute_names.delete(attribute_name)
          hash_datas = response&.dig(attribute_name)

          values = hash_datas&.map { |k, v| v if %w[uuid permalink value].include?(k) }&.compact || []
          dynamic_define_method(object, attribute_name, values)
          hash_datas&.each_key do |key|
            next unless %w[uuid permalink].include?(key)

            dynamic_define_method(object, key, hash_datas&.dig(key))
          end
        end

        object
      end

      private

      def dynamic_define_method(object, attribute_name, attribute_value)
        # Manually creates methods for both getter and setter and then
        #   sends a message to the new setter with the attribute_value
        object.class.send(:define_method, "#{attribute_name}=".to_sym) do |value|
          instance_variable_set("@#{attribute_name}", value)
        end

        object.class.send(:define_method, attribute_name.to_sym) do
          instance_variable_get("@#{attribute_name}")
        end

        object.send("#{attribute_name}=".to_sym, attribute_value)
      end

      # This is hash attributes
      #
      #   1. identifier
      def special_attributes
        %w[identifier]
      end

      def field_value(name, data)
        value = data[name]

        return value if value.nil? || value.is_a?(String)
        return parse_items(value, name) if value.is_a?(Array) && value[0].is_a?(Hash) && value[0].keys.include?('value')
        return value['value_usd'] if value.is_a?(Hash) && value.keys.include?('value_usd')
        return value['value'] if value.is_a?(Hash) && value.keys.include?('value')

        value
      end

      def parse_items(items, field_name)
        return items.collect { |e| e['value'] } unless field_name == 'activity_entities'

        # Sepcial case for activity_entities
        items.each_with_object([]) do |item, objects|
          card_model = case item['entity_def_id']
                       when 'person' then ::Crunchbase::Models::Person
                       when 'organization' then ::Crunchbase::Models::Organization
                       end
          # Alias: value is name
          item['name'] ||= item['value']

          next if card_model.nil?

          new_card_instance = card_model.new
          objects << dynamic_attributes(new_card_instance, new_card_instance.basis_fields, item)
        end
      end
    end
  end
end
