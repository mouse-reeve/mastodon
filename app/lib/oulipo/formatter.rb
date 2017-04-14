# frozen_string_literal: true
require 'nokogiri'
require 'oulipo/oulipo'
require 'formatter'

module Oulipo
  class Formatter < Formatter

    def format(status)
      html = super
      fragment = Nokogiri::HTML.fragment(html)
      fragment.traverse do |node|
        if node.text?
          node.content = node.content.gsub(FIFTH_GLYPH_REGEX, '*')
        end
      end
      fragment.serialize.html_safe # rubocop:disable Rails/OutputSafety
    end

  end
end
