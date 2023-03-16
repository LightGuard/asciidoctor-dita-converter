
# frozen_string_literal: true

require 'pathname'
require 'test_helper'


module Asciidoctor
  module Dita
    class GeneratedTestSuite < DitaConverterTestBase
      extend Asciidoctor::Dita::Testing

      create_adoc_based_tests
    end
  end
end
