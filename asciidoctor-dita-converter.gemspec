# frozen_string_literal: true

lib = File.expand_path 'lib', __dir__
$:.unshift lib unless $:.include? lib
require 'asciidoctor/dita/converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'asciidoctor-dita-converter'
  spec.version       = Asciidoctor::Dita::VERSION
  spec.authors       = ['Jason Porter']
  spec.email         = ['lightguard.jp@gmail.com']

  spec.summary       = 'Asciidoctor converter into dita, focused initially for IBM'
  spec.homepage      = 'https://github.com/LightGuard/asciidoctor-dita-converter'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.7'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #  spec.metadata["homepage_uri"] = spec.homepage
  #  spec.metadata["source_code_uri"] = "https://github.com/LightGuard/asciidoctor-dita-converter"
  #  spec.metadata["changelog_uri"] = ""
  # else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir File.expand_path(__dir__) do
    %x(git ls-files -z).split("\x0").reject {|f| f.match(%r{^(test|spec|features|data)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  # Building
  spec.add_development_dependency 'bundler', '~> 2.4.6'
  spec.add_development_dependency 'debug', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 13.0'

  # Testing
  spec.add_development_dependency 'minitest', '~> 5.0'

  # Other dev tools
  spec.add_development_dependency 'prettier_print', '~> 1.2'
  spec.add_development_dependency 'rubocop', '~> 1.47'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.28.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.16'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_development_dependency 'simple-xml', '~> 1.0'
  spec.add_development_dependency 'solargraph', '~> 0.48'
  spec.add_development_dependency 'syntax_tree', '~> 6.0'
  spec.add_development_dependency 'syntax_tree-haml', '~> 4.0'
  spec.add_development_dependency 'syntax_tree-rbs', '~> 1.0.0'

  # Required deps
  spec.add_runtime_dependency 'anyway_config', '>= 2.3.1'
  spec.add_runtime_dependency 'asciidoctor', '~> 2.0', '>= 2.0.18'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
