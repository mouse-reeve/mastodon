export default function oulipoify(text) {
  return text.replace(new RegExp(/[eE]/, 'g'), '*');
};
