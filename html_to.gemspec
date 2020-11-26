$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'charmer_utils'
  s.version     = '0.7.0'
  s.date        = '2019-08-31'
  s.summary     = 'Utils for work'
  s.description = 'Some utils for work'
  s.author      = 'Chekryzhov Viktor'
  s.email       = 'chekryzhov@charmerstudio.com'
  s.homepage    = 'https://github.com/Vchekryzhov/html-to'
  s.license     = 'MIT'
  s.files       = `git ls-files`.split("\n")
end
