# encoding: utf-8
require File.expand_path("../lib/entity_status/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "entity_status"
  s.version           = EntityStatus::VERSION
  s.authors           = ["Jeremy Bueler"]
  s.email             = ["jbueler@gmail.com"]
  s.homepage          = "https://github.com/jbueler/entity_status"
  s.summary           = "Simple entity status module for fetching and setting entities by status string."
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test}/*`.split("\n")
  s.require_paths     = ["lib"]
  s.license           = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'activerecord'

  s.description = <<-EOM
  A simple work in progress gem for adding status string to activerecord models.
  Creates scopes and status setting/testing methods.
EOM
end
