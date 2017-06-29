module Oulipo
  FIFTH_GLYPH_REGEX = /[eèéêëēėęǝɛ]/i
  URL_REGEX = /http.?:\/\/[^\s\\]+/
  MENTION_REGEX = /@[^\s\\]+@[^\s\\]+\.[a-z]+/
  EMOJI_REGEX = /\B:[a-zA-Z\d_]+:\B/
end
