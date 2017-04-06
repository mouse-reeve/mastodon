import en from './en';
import uk from './uk';

const locales = {
  en,
  uk,
};

export default function getMessagesForLocale (locale) {
  return locales[locale];
};
