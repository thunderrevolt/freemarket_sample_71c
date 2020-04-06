class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  validates :user_id, uniqueness: { scope: :product_id }

  def favorite_by?(product)
    Favorite.where(product_id: product.id).exists?
  end

end