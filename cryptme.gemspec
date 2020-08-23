version_file = File.expand_path("../lib/VERSION", __FILE__)
version = File.read(version_file)

Gem::Specification.new do |s|
  s.name        = 'cryptme'
  s.version     = version
  s.homepage    = 'https://github.com/happythenewsad/cryptme'
  s.date        = '2020-08-01'
  s.summary     = "A simple open source secrets manager"
  s.description = "A simple open source secrets manager"
  s.authors     = ["happythenewsad"]
  s.email       = 'happythenewsad@gmail.com'
  s.files       = ["lib/cryptme.rb"]
  s.executables << 'cryptme'
  s.license     = 'MIT'

  s.add_runtime_dependency 'clipboard', '~> 1.3'
  s.add_runtime_dependency 'ffi', '~> 1.3' # Required by Clipboard on Windows

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'pry', '~> 0.13'
end