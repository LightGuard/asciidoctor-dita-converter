# frozen_string_literal: true

$:.unshift File.expand_path('../lib', __dir__)

require 'pathname'
require 'minitest/autorun'
require 'rexml'
require 'rexml/document'
require 'simple_xml'

require 'asciidoctor'
require 'asciidoctor/dita/converter'

class DitaConverterTestBase < Minitest::Test
  attr_reader :asciidoctor_output, :expected_output, :full_output, :expected_attributes, :asciidoctor_attributes

  def setup
    super

    # outline will be handled differently
    return if name.include? 'test_outline'

    test_name = /^test_(.*)/.match(name)[1].gsub '_', '-'

    adoc_path = Pathname.new "test/examples/asciidoc/#{test_name}.adoc"
    dita_path = Pathname.new "test/examples/dita/#{test_name}.dita"

    raise NotImplementedError, 'No adoc file created' unless adoc_path.exist?
    raise NotImplementedError, 'No dita file created' unless dita_path.exist?

    output = Asciidoctor.convert adoc_path.cleanpath, safe: :safe, backend: 'dita', converter: ::Asciidoctor::Dita::Converter
    rexml_context = {ignore_whitespace_nodes: :all, compress_whitespace: :all}
    asciidoctor_document = REXML::Document.new output, rexml_context
    @asciidoctor_output = asciidoctor_document.simplify
    @asciidoctor_attributes = asciidoctor_document.simplify_attributes

    # Remove the ditamap if it's there
    ditamap = Pathname.new 'output.ditamap'
    ditamap.delete if ditamap.exist?

    @full_output = REXML::Document.new dita_path.read, ignore_whitespace_nodes: :all, compress_whitespace: :all
    @expected_output = @full_output.simplify '/topic/body'
    @expected_attributes = @full_output.simplify_attributes '/topic/body'

    #Minitest::Test.make_my_diffs_pretty!
  end
end

module Asciidoctor
  module Dita
    module Testing
      def create_adoc_based_tests
        adoc_files = Pathname.new 'test/examples/asciidoc'
        adoc_files.children.each do |adoc|
          next if File.directory? adoc

          example_name = File.basename adoc, '.adoc'
          example_name.gsub! '-', '_'

          # Outline is handled differently
          next if example_name.include? 'outline_'

          define_method %(test_#{example_name}) do
            assert_equal expected_output, asciidoctor_output
            assert_equal expected_attributes, asciidoctor_attributes
          end
        end
      end
    end
  end
end
