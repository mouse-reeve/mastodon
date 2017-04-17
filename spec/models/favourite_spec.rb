require 'rails_helper'

RSpec.describe Favourite, type: :model do
  let(:mus)  { Fabricate(:account, username: 'mus') }
  let(:bob)    { Fabricate(:account, username: 'bob') }
  let(:status) { Fabricate(:status, account: bob) }

  subject { Favourite.new(account: mus, status: status) }
end
