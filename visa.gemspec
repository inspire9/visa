# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'visa'
  spec.version       = '0.0.1'
  spec.authors       = ['Pat Allan']
  spec.email         = ['pat@freelancing-gods.com']
  spec.summary       = %q{Multi-token authentication for Rails apps.}
  spec.description   = %q{Multi-token authentication Rails engine.}
  spec.homepage      = 'https://github.com/inspire9/visa'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'bcrypt'
  spec.add_runtime_dependency     'rack'
  spec.add_runtime_dependency     'rails', '~> 4.0'

  spec.add_development_dependency 'combustion',  '0.5.1'
  spec.add_development_dependency 'rspec-rails', '~> 3.1'
  spec.add_development_dependency 'sqlite3',     '~> 1.3'
end
