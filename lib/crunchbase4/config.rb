# frozen_string_literal: true

require 'singleton'

# Root Crunchbase
module Crunchbase4
  # Config
  class Config
    include Singleton
    attr_accessor :user_key
  end

  def self.config
    yield Config.instance if block_given?

    Config.instance
  end
end
