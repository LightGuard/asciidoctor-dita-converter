# frozen_string_literal: true

require 'test_helper'

module Asciidoctor
  module Dita
    class ConverterTest < DitaConverterTestBase
      def test_admonition
        assert_equal asciidoctor_output, expected_output
      end
    end
  end
end
