require 'rails_helper'
include ActionDispatch::TestProcess

describe PrototypeImage, type: :model do
  let(:prototype){ create(:prototype) }
  let(:prototype_image){ create(:prototype_image, :main_image, prototype: prototype) }

   describe "#create" do
     it "has the wrong content format" do
       prototype_image = build(:prototype_image, :main_image, image: fixture_file_upload("spec/fixtures/img/sample.tiff", 'image/tiff'))
       prototype_image.valid?
       expect(prototype_image.errors[:image]).to include("許可リストに追加をしてください")
     end

     context "with valid attributes" do
       it "has a valid factory" do
         expect(prototype_image).to be_valid
       end
     end

     context "without content attributes" do
       it "returns error" do
         prototype_image = build(:prototype_image, :main_image, image: nil)
         prototype_image.valid?
         expect(prototype_image.errors[:image]).to include("を入力してください")
       end
     end

     context "without status attributes" do
       it "returns error" do
         prototype_image = build(:prototype_image, image_type: nil)
         prototype_image.valid?
         expect(prototype_image.errors[:image_type]).to include("を入力してください")
       end
     end
   end
   
end
