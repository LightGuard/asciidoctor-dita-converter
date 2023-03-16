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
        doctype: '<!DOCTYPE topic PUBLIC "-//OASIS//DTD DITA Topic//EN" "topic.dtd">',
        admonition: { before: %(<note type="<%= node.attr('name') %>">), after: '</note>' },
        audio: { before: '', after: '' },
        colist: { before: '', after: '' },
        dlist: { before: '', after: '' },
        # We're not supporting document, with this as we're expecting this to be a topic
        embedded: { before: '', after: '' },
        example: { before: '', after: '' },
        floating_title: { before: '', after: '' },
        image: { before: %(<image href="<%= node.attr 'href' %>"><alt><%= node.attr 'alt' %></alt>), after: '</image>' },
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
        paragraph: { before: '<p>', after: '</p>' },
        preamble: { before: '<abstract>', after: '<abstract>' },
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
