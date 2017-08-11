require 'rails_helper'

describe User, type: :model do
  describe "#create" do
    let(:user){ create(:user) }

    context "with valid attributes" do
      it "is valid with all information" do
        expect(user).to be_valid
      end
    end

    context "without valid attributes" do
      it "is invalid without a name" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "is invalid without an email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "is invalid without a password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "is invalid without a password_confirmation although a password" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end

      it "is invalid with a password that no match " do
        user = build(:user, password: "xxxxxx", password_confirmation: "xxxxxxx")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end

      it "is invalid with a duplicate email address" do
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "is invalid with a password taht has more than 6 characters" do
        user = build(:user, password: Faker::Internet.password(6))
        expect(user).to be_valid
      end

      it "is invalid with a password taht has less than 6 characters" do
        user = build(:user, password: "xxxxx")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

  end
end
