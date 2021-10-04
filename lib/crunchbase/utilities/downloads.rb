# frozen_string_literal: true

require_relative '../downloads/client'

module Crunchbase
  # Utilities
  module Utilities
    # Daily csv export
    module Downloads
      def download_bulk(dir, extract: false)
        Crunchbase::Downloads::Client.new.download_bulk(dir, extract: extract)
      end
    end
  end
end
