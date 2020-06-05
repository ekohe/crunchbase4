# frozen_string_literal: true

require 'singleton'

# Root Crunchbase
module Crunchbase
  # Config
  class Config
    include Singleton
    attr_accessor :user_key, :debug
  end

  def self.config
    yield Config.instance if block_given?

    Config.instance
  end
end
