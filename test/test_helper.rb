# frozen_string_literal: true

$:.unshift File.expand_path('../lib', __dir__)

require 'pathname'
require 'minitest/autorun'
require 'rexml/document'

require 'asciidoctor'
require 'asciidoctor/dita/converter'

class DitaConverterTestBase < Minitest::Test
  attr_reader :asciidoctor_output
  attr_reader :expected_output
  attr_reader :full_output

  def setup
    super
    test_name = /^test_(.*)/.match(name)[1]

    adoc_path = Pathname.new "test/examples/asciidoc/#{test_name}.adoc"
    @asciidoctor_output = REXML::Document.new(Asciidoctor.convert(adoc_path.cleanpath, safe: :safe, backend: 'dita', converter: ::Asciidoctor::Dita::Converter)).to_s
    
    # TODO load the full file, then run an xpath on it to pull the node we want
    dita_path = Pathname.new "test/examples/dita/#{test_name}.dita"
    @full_output = dita_path.read
    @expected_output = (REXML::XPath.first REXML::Document.new(@full_output), '//body/*').to_s
  end
end
