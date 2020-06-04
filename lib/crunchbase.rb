# frozen_string_literal: true

require 'crunchbase/version'

require 'crunchbase/config'
require 'crunchbase/utilities'
require 'crunchbase/client'
require 'crunchbase/entities'
require 'crunchbase/searches'
require 'crunchbase/models'
require 'crunchbase/errors'

module Crunchbase
  API_VERSION   = 'v4'
  BASE_URI      = "https://api.crunchbase.com/api/#{API_VERSION}/"
end
