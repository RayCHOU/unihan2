Gem::Specification.new do |s|
  s.name        = 'unihan2'
  s.version     = '1.1.0'
  s.date        = '2024-04-16'
  s.summary     = "Chinese"
  s.description = "Unihan Database Utilities"
  s.authors     = ["Ray Chou"]
  s.email       = 'zhoubx@gmail.com'
  s.files       = ["lib/unihan2.rb"] + Dir['lib/unihan2/*'] + Dir['data/*']
  s.homepage    =
    'https://github.com/RayCHOU/unihan2'
  s.license       = 'MIT'
end
