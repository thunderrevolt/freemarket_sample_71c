class Image < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :product, optional: true

  validates :image, presence: true, length: { in: 1..10 }
end
