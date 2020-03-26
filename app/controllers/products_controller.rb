class ProductsController < ApplicationController
  MAX_DISPLAY_RELATED_PRODUCTS = 3

  def index
    # @products = Product.includes(:images,:user).order('created_at DESC')
    # ↓新しく作成された3つのデータのみ取得。
    @products = Product.where(condition: 1).order(created_at: "DESC").take(MAX_DISPLAY_RELATED_PRODUCTS)
    # ↓1(出品中)のブランド名「ma--ru」の商品をshuffleメソッドとtakeメソッドでランダムで３つのデータを取得。distinctで重複する情報削除。
    @products_B = Product.where(condition:1, brand:'ma--ru').distinct.shuffle.take(MAX_DISPLAY_RELATED_PRODUCTS)
    
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to new_product_path unless @product.valid?
    end
  end

  

  def show
    @product = Product.find(params[:id])
    @comment = Comment.new
    @image_1 = Image.where(product_id: @product).first
    @image   = Image.where(product_id: @product)
  end


  def edit
    @product = Product.find(params[:id])
    @size = Size.find(@product.size_id)
    @images_length = @product.images.length
  end


  private
  def product_params
    params.require(:product).permit(images_attributes: [:image]).merge(user_id: current_user.id)
    # :name, :description, :category, :brand, :status, :postage_bearer, :shipping_area, :shipping_day, :price, :size,
  end

end
