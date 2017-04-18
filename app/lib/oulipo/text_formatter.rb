# frozen_string_literal: true
require 'oulipo/oulipo'

module Oulipo
  class TextFormatter

    def self.format(text)
      text.gsub(FIFTH_GLYPH_REGEX, '*') if text
    end

  end
end
