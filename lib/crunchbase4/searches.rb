# frozen_string_literal: true

# Crunchbase4 API
module Crunchbase4
  # Searches API
  module Searches
    autoload :Organization, 'crunchbase4/searches/organization'
    autoload :Person, 'crunchbase4/searches/person'
    autoload :Request, 'crunchbase4/searches/request'
  end
end
