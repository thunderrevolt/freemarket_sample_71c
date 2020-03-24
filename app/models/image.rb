class Image < ApplicationRecord
  mount_uploader :image, ImagesUploader
  belongs_to :product, optional: true
end
