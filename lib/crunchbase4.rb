# frozen_string_literal: true

require 'crunchbase4/version'

require 'crunchbase4/config'
require 'crunchbase4/request'
require 'crunchbase4/response'
require 'crunchbase4/client'
require 'crunchbase4/searches'
require 'crunchbase4/entities'
require 'crunchbase4/errors'

module Crunchbase4
  API_VERSION   = 'v4'
  BASE_URI      = "https://api.crunchbase.com/api/#{API_VERSION}/"
end
