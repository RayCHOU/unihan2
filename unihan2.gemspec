Gem::Specification.new do |s|
  s.name        = 'unihan2'
  s.version     = '0.0.4'
  s.date        = '2020-12-07'
  s.summary     = "Chinese"
  s.description = "Unihan Database Utilities"
  s.authors     = ["Ray Chou"]
  s.email       = 'zhoubx@gmail.com'
  s.files       = [
    "lib/unihan2.rb"
  ] + Dir['data/*']
  s.homepage    =
    'https://github.com/RayCHOU/unihan2'
  s.license       = 'MIT'
end