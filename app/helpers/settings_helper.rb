# frozen_string_literal: true

module SettingsHelper
  HUMAN_LOCALES = {
    en: 'Oulipo',
    uk: 'Українська',
    'zh-CN': '简体中文',
  }.freeze

  def human_locale(locale)
    HUMAN_LOCALES[locale]
  end

  def hash_to_object(hash)
    HashObject.new(hash)
  end
end
