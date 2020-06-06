# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # API Request
    module CbModel
      attr_accessor :entity_type

      module_function

      def cbobject
        kclass_name.new
      end

      def kclass_name
        @kclass_name ||= exact_kclass_object
      end

      def exact_kclass_object
        return entity_type if entity_type.is_a?(Class)

        cb_type = [
          'Crunchbase',
          'Models',
          entity_type.split('_').map(&:capitalize).join
        ].join('::')
        Kernel.const_get("::#{cb_type}")
      end
    end
  end
end
