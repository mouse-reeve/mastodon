require 'rails_helper'

RSpec.describe FeedManager do
  describe '#key' do
    subject { FeedManager.instance.key(:home, 1) }

    it 'returns a string' do
      expect(subject).to be_a String
    end
  end

  describe '#filter?' do
    let(:followee) { Fabricate(:account, username: 'mus') }
    let(:status)   { Fabricate(:status, text: 'Hllo world', account: followee) }
    let(:follower) { Fabricate(:account, username: 'bob') }

    subject { FeedManager.instance.filter?(:home, status, follower) }

    it 'returns a boolean value' do
      expect(subject).to be false
    end
  end
end
