# frozen_string_literal: true

require 'pathname'
require 'test_helper'

module Asciidoctor
  module Dita
    class GeneratedTestSuite < DitaConverterTestBase
      extend Asciidoctor::Dita::Testing

      def test_outline_basic
        adoc_path = Pathname.new "test/examples/asciidoc/outline-basic.adoc"
        dita_path = Pathname.new "test/examples/dita/outline-basic.ditamap"

        raise NotImplementedError, 'No adoc file created' unless adoc_path.exist?
        raise NotImplementedError, 'No dita file created' unless dita_path.exist?

        rexml_context = { ignore_whitespace_nodes: :all, compress_whitespace: :all }
        Asciidoctor.convert adoc_path.cleanpath, safe: :safe, backend: 'dita', converter: ::Asciidoctor::Dita::Converter

        output_file = Pathname.new "output.ditamap"
        asciidoctor_output_xml = REXML::Document.new output_file.read, rexml_context
        asciidoctor_output = asciidoctor_output_xml.simplify
        full_output_xml = REXML::Document.new dita_path.read, rexml_context
        full_output = full_output_xml.simplify

        # clean up
        output_file.delete

        assert_equal full_output, asciidoctor_output
        assert_equal full_output_xml.simplify_attributes("/map/topicref[1]"), asciidoctor_output_xml.simplify_attributes("/map/topicref[1]")
      end

      create_adoc_based_tests
    end
  end
end
