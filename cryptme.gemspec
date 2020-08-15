Gem::Specification.new do |s|
  s.name        = 'cryptme'
  s.version     = '0.0.1'
  s.date        = '2020-08-01'
  s.summary     = "A simple open source secrets manager"
  s.description = "A simple open source secrets manager"
  s.authors     = ["happythenewsad"]
  s.email       = 'happythenewsad@gmail.com'
  s.files       = ["lib/cryptme.rb"]
  s.homepage    = ''
  s.executables << 'cryptme'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'clipboard', '>= 1.3.4'
  s.add_runtime_dependency 'ffi' # Required by Clipboard on Windowss
end