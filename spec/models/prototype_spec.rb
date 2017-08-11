require 'rails_helper'

describe Prototype, type: :model do
  let(:user){ create(:user) }
  let(:prototype){ create(:prototype, user: user) }

  describe "associations" do
    context "with comments" do
      it "deletes the comments when prototype is deleted" do
        comment = create(:comment, prototype: prototype, user: user)
        expect{ prototype.destroy }.to change{ Comment.count }.by(-1)
      end
    end

    context "with likes" do
      it "deletes the likes when Prototype is deleted" do
        like = create(:like, prototype: prototype)
        expect{ prototype.destroy }.to change{ Like.count }.by(-1)
      end
    end
  end

  describe "validations" do
    context "with valid attributes" do
      it "has a valid facroty" do
        expect(prototype).to be_valid
      end
    end

    context "without valid attributes" do
      it "is missing a title" do
        prototype.title = nil
        prototype.valid?
        expect(prototype.errors[:title]).to include("を入力してください")
      end

      it "is missing a catch_copy" do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype.errors[:catch_copy]).to include("を入力してください")
      end

      it "is missing a text" do
        prototype = build(:prototype, text: nil)
        prototype.valid?
        expect(prototype.errors[:text]).to include("を入力してください")
      end
    end
  end

  describe "#posted_date" do
    it "returns dates in a specified format" do # 日付が正しく変換されているかどうか
      prototype = build(:prototype, created_at: '2017/08/09')
      expect( I18n.l prototype.created_at, format: :monthday ).to eq "8月 09日"
    end
  end

  describe "#liked_by?(user)" do
    context "when liked by a user" do
      it "return true" do # modelのlike_userのメソッドのテスト
        like = create(:like, prototype: prototype, user: user)
        expect(prototype.like_user(user)).to be_truthy
      end
    end

    context "when not liked a user" do
      it "returns nil" do # いいねしてなかったら、nilを返す
        prototype = create(:prototype, user: user)
        expect(prototype.like_user(user)).to be_falsey
      end
    end
  end

  describe "#set_main_images" do
    it "returns an array containing main_images" do
      prototype = create(:prototype)
      expect(prototype.main_prototype_image).to eq (prototype.prototype_images.first.image.url)
    end
  end

  describe "#reject_posts(attributed)" do
    it "doesn't save a record with nil image" do # reject_posts
      prototype = build(:prototype_image, prototype: prototype, image: nil)
      prototype.valid?
      expect( prototype.errors[:image] ).to include("を入力してください")
    end
  end

end
