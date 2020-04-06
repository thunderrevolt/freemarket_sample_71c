class FavoritesController < ApplicationController
  before_action :set_product, only: [:create, :destroy]

  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = current_user.favorites.build(product_id: params[:product_id])
    @favorite.save
  end

  def destroy
    current_user.favorites.find_by(product_id: params[:product_id]).destroy
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
