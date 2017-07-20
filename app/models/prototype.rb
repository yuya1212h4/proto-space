class Prototype < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :prototype_images, dependent: :destroy
  accepts_nested_attributes_for :prototype_images

  validates :title, presence: true

end
