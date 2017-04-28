# frozen_string_literal: true
require 'oulipo/oulipo'

module Oulipo
  class TextFormatter

    def self.format(text)
      text.gsub(Oulipo.invalid_glyphs_regex, '*') if text
    end

  end
end
