# frozen_string_literal: true
require 'anyway_config'

module Asciidoctor
  module Dita
    # Configuration for the surrounding tags during conversion.
    #
    # It provides the `instance` method, which returns the default
    # instance for this config.
    class MappingConfig < ::Anyway::Config
      config_name :mapping

      #
      # Values in the config mapping can be ERB templates
      #
      attr_config \
        template_location: 'templates',
        audio: { before: '', after: '' },
        colist: { before: '', after: '' },
        dlist: { before: '', after: '' },
        # We're not supporting document, with this as we're expecting this to be a topic
        embedded: { before: '', after: '' },
        example: { before: '', after: '' },
        floating_title: { before: '', after: '' },
        inline_anchor: { before: '', after: '' },
        inline_break: { before: '', after: '' },
        inline_button: { before: '', after: '' },
        inline_callout: { before: '', after: '' },
        inline_footnote: { before: '', after: '' },
        inline_image: { before: '', after: '' },
        inline_indexterm: { before: '', after: '' },
        inline_kbd: { before: '', after: '' },
        inline_menu: { before: '', after: '' },
        inline_quoted: { before: '<q>', after: '</q>' },
        listing: { before: '', after: '' }, # might need to be special
        literal: { before: '', after: '' },
        olist: { before: '', after: '' },
        open: { before: '', after: '' },
        outline: { before: '', after: '' },
        page_break: { before: '', after: '' },
        quote: { before: '<lq>', after: '</lq>' },
        # Not supporting config for section
        sidebar: { before: '', after: '' },
        stem: { before: '', after: '' },
        table: { before: '', after: '' },
        thematic_break: { before: '', after: '' },
        toc: { before: '', after: '' },
        ulist: { before: '', after: '' },
        verse: { before: '', after: '' },
        video: { before: '', after: '' }
    end
  end
end
