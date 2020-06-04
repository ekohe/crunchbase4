# frozen_string_literal: true

require_relative 'lib/crunchbase/version'

Gem::Specification.new do |spec|
  spec.name          = 'crunchbase4'
  spec.version       = Crunchbase::VERSION
  spec.authors       = ['Encore Shao']
  spec.email         = ['encore.shao@gmail.com']

  spec.summary       = 'Ruby Library for Crunchbase API Version 4.0'
  spec.description   = 'A Ruby wrapper for Crunchbase API version 4.0, crunchbase build new API interface by GraphQL'
  spec.homepage      = 'https://github.com/encoreshao/crunchbase4'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  spec.post_install_message = 'Thanks for installing!'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/encoreshao/crunchbase4'
  spec.metadata['changelog_uri'] = 'https://github.com/encoreshao/crunchbase4/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'

  # VCR for testing APIs
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  # Rubocop
  spec.add_development_dependency 'rubocop'
  # For debug binding.pry
  spec.add_development_dependency 'pry'
end
