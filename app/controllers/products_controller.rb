class ProductsController < ApplicationController
  def index
    # @products = Product.includes(:images,:user).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    binding.pry
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path unless @product.valid?
    end
  end

  def edit
    @product = Product.find(params[:id])
    @size = Size.find(@product.size_id)
    @images_length = @product.images.length
  end


  private
  def product_params
    params.require(:product).permit(images_attributes: [:image]).merge(user_id: 1)
    # :name, :description, :category, :brand, :status, :postage_bearer, :shipping_area, :shipping_day, :price, :size,
  end

end
