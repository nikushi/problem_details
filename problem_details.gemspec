# frozen_string_literal: true

version = File.read(File.expand_path('VERSION', __dir__)).strip

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'problem_details'
  spec.version       = version
  spec.authors       = ['Nobuhiro Nikushi']
  spec.email         = ['deneb.ge@gmail.com']

  spec.summary       = 'An implementation of RFC 7807 Problem Details for HTTP APIs'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/nikushi/problem_details'
  spec.license       = 'MIT'

  spec.files         = `git ls-files|grep -v rails`.split($OUTPUT_RECORD_SEPARATOR).reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
