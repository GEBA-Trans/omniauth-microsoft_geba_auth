# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/microsoft_geba_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-microsoft_geba_auth"
  spec.version       = Omniauth::MicrosoftV2Auth::VERSION
  spec.authors       = ["Kai-Arne Reiter"]
  spec.email         = ["k.reiter@gebatrans.com"]
  spec.summary       = %q{omniauth provider for Microsoft V2 Authentication}
  spec.description   = %q{omniauth provider for Microsoft V2 Authentication}
  spec.homepage      = "https://github.com/GEBA-Trans/omniauth-microsoft_geba_auth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth-oauth2", ">= 1.8.0"
  spec.add_runtime_dependency "oauth2", ">= 2.0.4"
end
