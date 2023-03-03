# frozen_string_literal: true

require 'test_helper'

class Asciidoctor::Dita::ConverterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Asciidoctor::Dita::Converter::VERSION
  end
end
