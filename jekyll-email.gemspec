# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/email/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-email"
  spec.version       = Jekyll::Email::VERSION
  spec.authors       = ["kisakov"]
  spec.email         = ["isakov90@gmail.com"]

  spec.summary       = %q{jekyll email plugin}
  spec.description   = %q{Send emails with simple command}
  spec.homepage      = "http://github.com/kisakov/jekyll-email"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jekyll', '~> 3.3'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug"
  spec.add_runtime_dependency "mail"
  spec.add_runtime_dependency "dotenv"
  spec.add_runtime_dependency "letter_opener"
  spec.add_runtime_dependency "highline"
end
