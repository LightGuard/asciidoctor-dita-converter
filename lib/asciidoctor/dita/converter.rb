# frozen_string_literal: true

require 'asciidoctor'
require 'asciidoctor/converter'
require 'erb'
require 'pathname'

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

      def respond_to_missing? method_name, include_private = false
        #p "NEED METHOD MISSING FOR: #{method_name}"
        true
      end

      def method_missing(method_name, *args, &block)
        # TODO get the asciidoctor logger
        template_name = method_name.to_s.sub 'convert_', ''

        template_file = Pathname.new(@config.send('template_location')).join "#{template_name}.erb"
        raise StandardError, "Template not found: #{template_file}" unless template_file.exist?
        template_contents = template_file.read

        b = binding
        b.local_variable_set :node, args[0]

        ERB.new(template_contents, trim_mode: '<>-').result b
      end

      def convert_table node, opts = {}
        result = []

        result << %(<#{tag_name = node.title ? 'table' : 'simpletable'}#{common_attributes node.id}>)
        result << %(<title>#{node.title}</title>) if tag_name == 'table'

        result.concat simpletable(node, opts) if tag_name == 'simpletable'
        result.concat table(node, opts) if tag_name == 'table'

        result << %(</#{tag_name}>)
        result.join LF
      end

      def table node, opts = {}
        result = []
        result.join LF
      end

      def simpletable node, opts = {}
        result = []
        node.rows.to_h.each do |section, rows|
          next if rows.empty?
          if section == :head
            result << %(<sthead>)
            # Should only ever be one header row
            rows[0].each do |cell|
              result << %(<stentry>#{cell.text}</stentry>)
            end
            result << %(</sthead>)
          else
            rows.each do |row|
              result << %(<strow>)
              row.each do |cell|
                cell_element = '<stentry>'
                case cell.style
                when :asciidoc
                  cell_element += cell.content
                when :literal
                  cell_element += %(<tt>#{cell.text}</tt>)
                when :header
                  cell_element += %(<b>#{cell.text}</b>)
                else
                  cell_element += cell.text
                end
                result << cell_element + '</stentry>'
              end
              result << %(</strow>)
            end
          end
        end
        result
      end

      def convert_outline node, opts = {}
        return unless node.sections?

        # Thanks Dan, from asciidoctor source
        toclevels = (opts[:toclevels] || node.document.attributes['toclevels'] || 3).to_i
        result = []

        node.sections.each do |section|
          slevel = section.level
          stitle = section.captioned_title || section.title || ''
          link = "##{section.id}"

          if slevel <= toclevels
            child_toc = convert_outline section, {seclevel: slevel}
            result << %(<topicref href="#{link}" format="html" navtitle="#{stitle}" scope="peer">#{child_toc}</topicref>)
          end
        end

        if node.parent.nil?
          if node.embedded?
            filename = Pathname.new 'output.ditamap'
          else
            filename = Pathname.new(node.attributes['outfile'].gsub(/\.dita$/, '.ditamap'))
          end
          result.unshift %(<?xml version="1.0" encoding="utf-8"?>\n<map xml:lang="en-us">\n<title>#{node.title}</title>)
          result << %(</map>)

          File.write filename, result.join("\n")
        else
          result.join "\n"
        end
      end

      def convert_toc node, opts = {}
        convert_outline node, opts
      end

      def common_attributes id, role = nil, reftext = nil
        return %(id="#{id}") if id
      end
    end
  end
end
