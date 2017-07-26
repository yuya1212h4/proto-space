class PrototypeImage < ApplicationRecord

  belongs_to :prototype, optional: true
  enum image_type: { main: 0, sub: 1 }
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :image_type, presence: true
end
