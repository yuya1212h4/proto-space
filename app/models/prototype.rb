class Prototype < ApplicationRecord

  belongs_to :user
  # FIXME: prototypeを削除するときにエラーが出るために、一度コメントアウト
  # has_many :comments, dependent: :destroy
  # has_many :likes, dependent: :destroy
  has_many :prototype_images, dependent: :destroy
  accepts_nested_attributes_for :prototype_images, allow_destroy: true, reject_if: :reject_posts

  # FIXME: それぞれのエラーが個別で出力されるように修正
  validates :title, presence: true
  validates :text, presence: true
  validates :catch_copy, presence: true
  validates :PrototypeImage, presence: true

  def  main_prototype_image
    prototype_images.first.image.url
  end

  def PrototypeImage
    prototype_images[0].image if prototype_images[0].present?
  end

  def reject_posts(attributed)
    attributed['image'].blank?
  end

  paginates_per 8 #1ページあたりの表示数
end
