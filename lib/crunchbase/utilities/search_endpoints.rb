# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # All Searches API endpoint
    module SearchEndpoints
      # For Searches

      def searches(keyword, scope_name: nil)
        kclass = Kernel.const_get("Crunchbase::Searches::#{scope_name}")
        kclass.new('name', keyword).search
      end
    end
  end
end
