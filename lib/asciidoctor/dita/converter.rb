# frozen_string_literal: true

require 'asciidoctor'
require 'asciidoctor/converter'
require 'erb'

require_relative 'converter/mapping_config'

module Asciidoctor
  module Dita
    #
    # Asciidoctor converter to convert AsciiDoc syntax into a DITA topic
    #
    class Converter < ::Asciidoctor::Converter::Base
      register_for 'dita'

      def initialize *opts
        super
        outfilesuffix '.dita'

        # TODO add in the configuration stuff
        @config = MappingConfig.new
      end

      #
      # Convert the document node
      #
      # @param [AbstractNode] node Asciidoc AST node
      #
      # @return [String] converted output
      #
      def convert_document node
        puts "INSIDE convert_document"
        <<~TOPIC.chomp
          <?xml version="1.0" encoding="utf-8"?>
          #{mapping_for :doctype}
          <topic id="#{node.id}" xml:lang="en-us">
          <title>#{node.doctitle}</title>
          <body>
          #{node.content}
          </body>
          </topic>
        TOPIC
      end

      def convert_section node
        puts "INSIDE convert_section"
        <<~SECTION.chomp
          <section id="#{node.id}">
          <title>#{node.title}</title>
          #{node.content}
          </section>
        SECTION
      end

      def convert_paragraph node
        simple_mapping node, :paragraph
      end

      def convert_admonition node
        simple_mapping node, :admonition
      end

      def convert_image node
        simple_mapping node, :image
      end

      def convert_inline_quoted node
        simple_mapping node, :inline_quoted
      end

      def convert_audio node
        simple_mapping node, :audio
      end

      def convert_colist node
        # TODO more list stuff
      end

      def convert_dlist node
        # TODO more list stuff
      end

      def convert_embedded node
        simple_mapping node, :embedded
      end

      def convert_example node
        simple_mapping node, :example
      end

      def convert_floating_title node
        simple_mapping node, :floating_title
      end

      def convert_inline_anchor node
        simple_mapping node, :inline_anchor
      end

      def convert_inline_break node
        simple_mapping node, :inline_break
      end

      def convert_inline_button node
        simple_mapping node, :inline_button
      end

      def convert_inline_callout node
        simple_mapping node, :inline_callout
      end

      def convert_inline_footnote node
        simple_mapping node, :inline_footnote
      end

      def convert_inline_image node
        simple_mapping node, :inline_image
      end

      def convert_inline_indexterm node
        simple_mapping node, :inline_indexterm
      end

      def convert_inline_kbd node
        simple_mapping node, :inline_kbd
      end

      def convert_inline_menu node
        simple_mapping node, :inline_menu
      end

      def convert_listing node
        simple_mapping node, :listing
      end

      def convert_literal node
        simple_mapping node, :literal
      end

      def convert_olist node
        # TODO more list stuff
      end

      def convert_open node
        # TODO figure out what to do about open blocks
        simple_mapping node, :open
      end

      def convert_outline node
        simple_mapping node, :outline
      end

      def convert_page_break node
        simple_mapping node, :page_break
      end

      def convert_preamble node
        simple_mapping node, :preamble
      end

      def convert_quote node
        simple_mapping node, :quote
      end

      def convert_sidebar node
        simple_mapping node, :sidebar
      end

      def convert_stem node
        simple_mapping node, :stem
      end

      def convert_table node
        simple_mapping node, :table
      end

      def convert_thematic_break node
        simple_mapping node, :thematic_break
      end

      def convert_toc node
        simple_mapping node, :toc
      end

      def convert_ulist node
        # TODO more list stuff
      end

      def convert_verse node
        simple_mapping node, :verse
      end

      def convert_video node
        simple_mapping node, :video
      end

      private

      def mapping_for context
        @config ||= Asciidoctor::Dita::MappingConfig.new

        @config.send context
      end

      def simple_mapping node, context
        mapping = mapping_for context
        template = %(#{mapping['before']}#{node.content}#{mapping['after']})
        ERB.new(template).result binding
      end
    end
  end
end
