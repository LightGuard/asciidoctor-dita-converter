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
        p "NEED METHOD MISSING FOR: #{method_name}"
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

      def common_attributes id, role = nil, reftext = nil
        return %(id="#{id}") if id
      end
    end
  end
end
