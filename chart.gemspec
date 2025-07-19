# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chart/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version             = '3.4.2'
  spec.name                              = 'chart'
  spec.version                           = Chart::VERSION
  spec.authors                           = ['hezbymuhammad']
  spec.email                             = ['hezbymuhammad@gmail.com']
  spec.summary                           = 'simple chart app'
  spec.description                       = 'simple chart app'
  spec.homepage                          = 'http://github.com/hezbymuhammad'
  spec.license                           = 'MIT'

  spec.files                             = `git ls-files -z`.split("\x0")
  spec.bindir                            = 'bin'
  spec.executables                       = ['chart']
  spec.require_paths                     = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
