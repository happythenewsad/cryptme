Dir[File.expand_path(File.join(File.dirname(__FILE__), '*.rb'))].each {|f| require f }

module Cryptme
  VERSION = '0.0.6'
end