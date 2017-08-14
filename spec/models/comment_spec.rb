require 'rails_helper'

describe Comment, type: :model do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype) }
  let(:comment){ create(:comment, user: user, prototype: prototype) }

  describe "association" do
    it 'is associated with a prototype' do
      expect(comment.prototype).to eq prototype
    end

    it 'is associated with a user' do
      expect(comment.user).to eq user
    end
  end

end
