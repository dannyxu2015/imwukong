lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imwukong/version'
Gem::Specification.new do |s|
  s.name        = 'imwukong'
  s.version     = Imwukong::VERSION
  s.date        = '2015-12-03'
  s.summary     = "I am Wukong!"
  s.description = "imwukong server API"
  s.authors     = ["Danny Xu"]
  s.email       = 'dannyxu@gmail.com'
  s.files       = ["lib/imwukong.rb"]
  s.homepage    = 'http://rubygems.org/gems/imwukong'
  s.license     = 'GNU2'
end