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
      if toot_text(text).match?(/[eèéêëēėęǝɛ]/i)
        status.errors.add(field, 'contains invalid symbol')
      end
    end

    def toot_text(text)
      [/http.?:\/\/[^\s\\]+/, /@[^\s\\]+@[^\s\\]+\.[a-z]+/, /\B:[a-zA-Z\d_]+:\B/].each do |regex|
        text = strip_matches(text, regex)
      end
      return text
    end

    def strip_matches(text, regex)
      text.gsub(regex, '')
    end

  end
end
