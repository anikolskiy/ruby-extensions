lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ruby-extensions'

Gem::Specification.new do |s|
  s.name        = 'ruby-extensions'
  s.version     = '1.0.0'
  s.author      = 'Ing. Alexander Nikolskiy'
  s.email       = 'a.nikolskiy@hs-interactive.eu'
  s.homepage    = 'https://github.com/anikolskiy/ruby-extensions'
  s.summary     = 'Useful Ruby extensions'
  s.description = 'Useful Ruby extensions'

  s.files = `git ls-files`.split("\n")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = %w[lib]

  s.add_dependency 'rails'
end
