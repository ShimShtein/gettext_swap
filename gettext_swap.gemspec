# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gettext_swap/version'

Gem::Specification.new do |spec|
  spec.name          = 'gettext_swap'
  spec.version       = GettextSwap::VERSION
  spec.authors       = ['Shimon Shtein\n']
  spec.email         = ['sshtein@redhat.com']
  spec.homepage      = 'https://github.com/shimshtein/gettext_swap'

  spec.summary       = 'Replaces words from strings marked for translation'
  spec.description   = <<-DESC
  Uses a special wrapper fast_gettext repository to replace translated string in runtime.
  The set of rules is pecified in a yaml file.
  DESC

  spec.require_paths = ['lib']

  spec.files = Dir['{lib,locale,config}/**/*']
  spec.files += ['LICENSE', 'Rakefile', 'README.md']
  spec.test_files = Dir['test/**/*']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'fast_gettext'
  spec.add_dependency 'activesupport'
end
