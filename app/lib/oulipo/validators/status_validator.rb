# frozen_string_literal: true
require 'oulipo/oulipo'

module Oulipo
  class Validators::StatusValidator < ActiveModel::Validator

    def validate(status)
      if status.local? && toot_text(status).match?(FIFTH_GLYPH_REGEX)
        status.errors.add(:text, I18n.t('oulipo.invalid_symbol'))
      end
    end

    private

    def toot_text(status)
      no_urls = strip_urls(status.text)
      strip_mentions(no_urls)
    end

    def strip_urls(text)
      text.gsub(/http.?:\/\/[^\s\\]+/, '')
    end

    def strip_mentions(text)
      text.gsub(/@[^\s\\]+@[^\s\\]+\.[a-z]+/, '')
    end

  end
end
