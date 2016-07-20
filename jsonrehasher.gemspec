# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "jsonrehasher"
  spec.version       = '1.0.0'
  spec.authors       = ["Jason Giedymin"]
  spec.email         = ["jason.giedymin@gmail.com"]
  spec.summary       = "JSON Rehasher"
  spec.description   = "JSON Rehasher"
  # spec.homepage      = "http://domainforproject.com/"
  spec.files         = Dir['lib/**/*', 'lib/v1/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','Gemfile']
  spec.license       = "Nonstandard"
  # spec.executables   = ['bin/NAME']
  # spec.test_files    = Dir['tests/**/*']
  spec.require_paths = ["lib"]
end
