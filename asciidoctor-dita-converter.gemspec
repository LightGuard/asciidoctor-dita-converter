
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "asciidoctor/dita/converter/version"

Gem::Specification.new do |spec|
  spec.name          = "asciidoctor-dita-converter"
  spec.version       = Asciidoctor::Dita::Converter::VERSION
  spec.authors       = ["Jason Porter"]
  spec.email         = ["lightguard.jp@gmail.com"]

  spec.summary       = %q{Asciidoctor converter into dita, focused initially for IBM}
  spec.homepage      = "https://github.com/LightGuard/asciidoctor-dita-converter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  #  spec.metadata["homepage_uri"] = spec.homepage
  #  spec.metadata["source_code_uri"] = "https://github.com/LightGuard/asciidoctor-dita-converter"
  #  spec.metadata["changelog_uri"] = ""
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Building
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"

  # Testing
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "asciidoctor-doctest", "= 2.0.0.beta.7"

  # Other dev tools
  spec.add_development_dependency "rubocop", "~> 1.47"
  spec.add_development_dependency "rubocop-performance", "~> 1.16"
  spec.add_development_dependency "rubocop-minitest", "~> 0.28.0"
  spec.add_development_dependency "rubocop-rake", "~> 0.6.0"

  # Required deps
  spec.add_runtime_dependency "anyway_config", ">= 2.3.1"
  spec.add_runtime_dependency "asciidoctor", "~> 2.0", ">= 2.0.18"
end
