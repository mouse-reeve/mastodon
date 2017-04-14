require 'rails_helper'

RSpec.describe Oulipo::StatusFormatter do

  let(:account)       { Fabricate(:account, username: 'al') }
  let(:simple_status)  { Fabricate.build(:status, text: 'Mice èat chéêsë!', account: account) }
  let(:link_status)  { Fabricate.build(:status, text: 'Lovē this Excėllęnt sitǝ: https://example.com', account: account) }
  let(:mention_status)  { Fabricate.build(:status, text: 'Hɛy @ecmendenhall@party.personal.pizza', account: account) }
  let(:remote_status) { Fabricate(:status, text: '<script>alert("Hello")</script> Beep boop', uri: 'beepboop', account: account) }

  describe '#format' do
    describe 'simple statuses' do
      subject { Oulipo::StatusFormatter.instance.format(simple_status) }

      it 'blocks that fifth glyph' do
        expect(subject).to match(
          '<p>Mic* *at ch**s*!</p>'
        )
      end
    end

    describe 'statuses with links' do
      subject { Oulipo::StatusFormatter.instance.format(link_status) }

      it 'blocks that fifth glyph' do
        expect(subject).to match(
          '<p>Lov* this *xc*ll*nt sit*: <a href="https://example.com" rel="nofollow noopener" target="_blank"><span class="invisible">https://</span><span class="">*xampl*.com</span><span class="invisible"></span></a></p>'
        )
      end
    end

    describe 'statuses with mentions' do
      subject { Oulipo::StatusFormatter.instance.format(mention_status) }

      it 'blocks that fifth glyph' do
        expect(subject).to match(
          '<p>H*y @*cm*nd*nhall@party.p*rsonal.pizza</p>'
        )
      end
    end
  end

  describe '#reformat' do
    subject { Oulipo::StatusFormatter.instance.format(remote_status) }

    it 'returns a string' do
      expect(subject).to be_a String
    end

    it 'contains plain text' do
      expect(subject).to match('B\*\*p boop')
    end

    it 'does not contain scripts' do
      expect(subject).to_not match('<script>alert("Hello")</script>')
    end
  end
end
