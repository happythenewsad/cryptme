Gem::Specification.new do |s|
  s.name        = 'melon'
  s.version     = '0.0.0'
  s.date        = '2020-08-01'
  s.summary     = "A simple open source secrets manager"
  s.description = "A simple open source secrets manager"
  s.authors     = ["happythenewsad"]
  s.email       = 'happythenewsad@gmail.com'
  s.files       = ["lib/melon.rb"]
  s.homepage    = ''
  s.executables << 'melon'
  
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'clipboard', '>= 1.3.4'
  s.add_runtime_dependency 'ffi', :platforms => [:mswin, :mingw] 
  s.license     = 'MIT'
end