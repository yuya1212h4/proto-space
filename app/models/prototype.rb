class Prototype < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :prototype_images, dependent: :destroy
  accepts_nested_attributes_for :prototype_images, reject_if: :reject_posts

  validates :title, presence: true
  validates :PrototypeImage, presence: true

 def PrototypeImage
   prototype_images[0].image if prototype_images[0].present?
 end

 def reject_posts(attributed)
   attributed['image'].blank?
 end

end
