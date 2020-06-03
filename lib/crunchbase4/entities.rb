# frozen_string_literal: true

# Crunchbase API
module Crunchbase4
  # Entities API
  module Entities
    autoload :Organization, 'crunchbase4/entities/organization'
    autoload :Person, 'crunchbase4/entities/person'
    autoload :Request, 'crunchbase4/entities/request'
  end
end
