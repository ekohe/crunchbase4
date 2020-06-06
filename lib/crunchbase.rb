# frozen_string_literal: true

require 'crunchbase/version'

require 'crunchbase/config'
require 'crunchbase/client'
require 'crunchbase/models'
require 'crunchbase/entities'
require 'crunchbase/searches'
require 'crunchbase/utilities/veriables'

# CB v4
module Crunchbase
  API_VERSION   = 'v4'
  BASE_URI      = "https://api.crunchbase.com/api/#{API_VERSION}/"

  # Defined Veriables for the data Category or Types
  #
  # Crunchbase::Utils.constants => [
  #   :OPERATING_STATUS,
  #  :PROGRAM_TYPES,
  #  :REVENUE_RANGES,
  #  :COMPANY_TYPES,
  #  :FACET_IDS,
  #  :SCHOOL_METHODS,
  #  :IPO_STATUS,
  #  :FUNDING_STAGES,
  #  :CURRENCY_ENUM,
  #  :DATE_PRECISIONS,
  #  :LAYOUT_IDS,
  #  :NUM_EMPLOYEES_ENUM,
  #  :FUNDING_TYPES,
  #  :SCHOOL_TYPES,
  #  :QUERY_OPERATORS,
  #  :STATUS,
  #  :STOCK_EXCHANGE_SYMBOLS
  # ]
  #
  #  Crunchbase::Utils::NUM_EMPLOYEES_ENUM
  class Utils
    include Utilities::Veriables
  end
end
