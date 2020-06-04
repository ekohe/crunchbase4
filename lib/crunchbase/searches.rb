# frozen_string_literal: true

module Crunchbase
  # Searches API
  module Searches
    autoload :Organization, 'crunchbase/searches/organization'
    autoload :Person, 'crunchbase/searches/person'
    autoload :Request, 'crunchbase/searches/request'
  end
end
