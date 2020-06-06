# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # API Request
    module CbModel
      attr_accessor :model_name

      module_function

      def cbobject
        kclass_name.new
      end

      def kclass_name
        @kclass_name ||= exact_kclass_object
      end

      def exact_kclass_object
        return model_name if model_name.is_a?(Class)

        cb_model_name = [
          'Crunchbase',
          'Models',
          model_name.split('_').map(&:capitalize).join
        ].join('::')
        Kernel.const_get("::#{cb_model_name}")
      end
    end
  end
end
