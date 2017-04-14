# frozen_string_literal: true
require 'oulipo/oulipo'

module Oulipo
  class Validators::StatusValidator < ActiveModel::Validator

    def validate(status)
      if status.local?
        validate_text(:text, status)
        validate_text(:spoiler_text, status)
      end
    end

    private

    def validate_text(field, status)
      text = status.send(field)
      if toot_text(text).match?(FIFTH_GLYPH_REGEX)
        status.errors.add(field, I18n.t('oulipo.invalid_symbol'))
      end
    end

    def toot_text(text)
      no_urls = strip_urls(text)
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
