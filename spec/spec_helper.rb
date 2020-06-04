# frozen_string_literal: true

require 'bundler/setup'
require 'crunchbase'
require 'pry'

api_key = if File.exist?('crunchbase.yml')
            require 'yaml'
            YAML.load_file(File.join(File.dirname(__FILE__), 'crunchbase.yml'))['user_key']
          else
            'api_key'
          end
Crunchbase.config.user_key = api_key

require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true

  # Removes all private data (Basic Auth, Set-Cookie headers...)
  config.before_record do |interaction|
    interaction.response.headers.delete('Set-Cookie')
    interaction.request.headers.delete('X-Cb-User-Key')
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
