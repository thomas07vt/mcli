# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mcli/version'

Gem::Specification.new do |spec|
  spec.name          = "mcli"
  spec.version       = MCLI::VERSION
  spec.authors       = ["John Thomas"]
  spec.email         = ["thomas07@vt.edu"]

  spec.summary       = %q{Create CLI tools using ruby objects with a nice API}
  spec.homepage      = "https://github.com/thomas07vt/mcli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/mcli}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
