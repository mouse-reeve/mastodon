module Oulipo
  FIFTH_GLYPH_REGEX = /[eèéêëēėęǝɛ]/i
  URL_REGEX = /http.?:\/\/[^\s\\]+/
  MENTION_REGEX = /@[^\s\\]+@[^\s\\]+\.[a-z]+/
  EMOJI_REGEX = /\B:[a-zA-Z\d_]+:\B/

  def self.set_invalid_glyphs!(regex)
    Config.instance.invalid_glyphs_regex = regex
  end

  def self.invalid_glyphs_regex
    Config.instance.invalid_glyphs_regex
  end

  class Config
    include Singleton

    attr_accessor :invalid_glyphs_regex
  end
end
