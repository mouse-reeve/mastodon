require 'rails_helper'

RSpec.describe Oulipo::TextFormatter do
  subject { Oulipo::TextFormatter }

  before :each do
    Oulipo.set_invalid_glyphs!(Oulipo::FIFTH_GLYPH_REGEX)
  end

  describe '#format' do

    it 'blocks that fifth glyph' do
      expect(subject.format('Mice èat chéêsë!')).to match(
        'Mic* *at ch**s*!'
      )
    end

    it 'handles nil' do
      expect(subject.format(nil)).to eq(nil)
    end
  end
end
