# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'numberjack/version'

Gem::Specification.new do |spec|
  spec.name          = 'numberjack'
  spec.version       = Numberjack::VERSION
  spec.author        = 'LeadMachine (forked from MOBI Wireless Management)'
  spec.email         = ['jakcharlton@gmail.com']
  spec.summary       = 'Phone number validation forked from MOBI Wireless Management'
  spec.homepage      = 'https://github.com/leamachineapp/numberjack'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'activemodel', '>= 4.0'
  spec.add_development_dependency 'minitest-focus'
  spec.add_development_dependency 'coveralls'
end
