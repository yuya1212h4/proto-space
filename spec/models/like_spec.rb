require 'rails_helper'

describe Like, type: :model do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype) }
  let(:like){ create(:like, prototype: prototype, user: user) }

  describe "assciation" do
    it 'is associated with a ptototype' do
      expect(like.prototype).to eq prototype
    end

    it 'is associated with a user' do
      expect(like.user).to eq user
    end
  end

end
