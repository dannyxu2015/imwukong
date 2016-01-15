# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imwukong/version'

Gem::Specification.new do |spec|
  spec.name          = "imwukong"
  spec.version       = Imwukong::VERSION
  spec.authors       = ["Danny Xu"]
  spec.email         = ["dannyxu@gmail.com"]

  spec.summary       = %q{I am Wukong!}
  spec.description   = %q{ruby server api for imwukong of alibaba}
  spec.homepage      = "https://github.com/dannyxu2015/imwukong"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_dependency "httpclient", "~> 2.7.0.1"
  spec.add_dependency "activesupport", "~> 4.2.0"
end
