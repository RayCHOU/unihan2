Gem::Specification.new do |s|
  s.name        = 'unihan2'
  s.version     = '0.0.1'
  s.date        = '2015-08-28'
  s.summary     = "Chinese"
  s.description = "Unihan Database Utilities"
  s.authors     = ["Ray Chou"]
  s.email       = 'zhoubx@gmail.com'
  s.files       = [
    "lib/unihan2.rb"
  ] + Dir['data/*']
  s.homepage    =
    'http://rubygems.org/gems/chinese'
  s.license       = 'MIT'
end