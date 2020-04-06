class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :status, presence: true
  validates :postage_bearer, presence: true
  validates :shipping_area, presence: true
  validates :shipping_day, presence: true
  validates :price, presence: true, inclusion: 300..9999999
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :condition, presence: true

  def favorite_by?(product)
    Favorite.where(product_id: product.id).exists?
  end

end
