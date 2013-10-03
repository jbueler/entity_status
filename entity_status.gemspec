# encoding: utf-8
require File.expand_path("../lib/entity_status/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "entity_status"
  s.version           = EntityStatus::VERSION
  s.authors           = ["Jeremy Bueler"]
  s.email             = ["jbueler@gmail.com"]
  s.homepage          = "https://github.com/jbueler/entity_status"
  s.summary           = "Simple entity status module for fetching and setting entities by status string."
  # s.rubyforge_project = "friendly_id"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test}/*`.split("\n")
  s.require_paths     = ["lib"]
  s.license           = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'activerecord'

  # s.add_development_dependency 'railties', '~> 4.0.0'
  # s.add_development_dependency 'minitest', '>= 4.4.0'
  # s.add_development_dependency 'mocha', '~> 0.13.3'
  # s.add_development_dependency 'yard'
  # s.add_development_dependency 'i18n'
  # s.add_development_dependency 'ffaker'
  # s.add_development_dependency 'simplecov'
  # s.add_development_dependency 'redcarpet'

  s.description = <<-EOM
  A simple work in progress gem for adding status string to activerecord models.
  Creates scopes and status setting/testing methods.
EOM
end