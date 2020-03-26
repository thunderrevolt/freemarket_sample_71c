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
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    array = Category.where(ancestry: nil).pluck(:name)
    @category_parent_array.push(array)
    @category_parent_array.flatten!
   
    def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    end

      # 子カテゴリーが選択された後に動くアクション
    def get_category_grandchildren
      #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end
   
  end


  def create
    @product = Product.new(product_params)
    category_id_params
    if @product.save
      params[:images][:image].each do |a|
        @images = @product.images.create!(image: a, product_id: @product.id)
      end
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

  def destroy
    @product = Product.find_by(params[:id])
    @product.destroy
    redirect_to root_path
  end


  private
  def product_params
    params.require(:product).permit(:name, :description, :brand, :status, :postage_bearer, :shipping_area, :shipping_day, :price, :size, :category_id, :condition ,images_attributes: [:id, {images: []}, :post_id]).merge(user_id: current_user.id)
  end

  def category_id_params
    category = params.permit(:category_id)
    @product[:category_id] = category[:category_id]
  end
end
