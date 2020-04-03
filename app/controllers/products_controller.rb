class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show, :search]
  MAX_DISPLAY_RELATED_PRODUCTS = 3
  before_action :user_to_current_user?, only: [:edit, :update]
  

  def index
    # @products = Product.includes(:images,:user).order('created_at DESC')
    # ↓新規投稿商品。新しく作成された3つのデータのみ取得。
    @products = Product.where(condition: 1).order(created_at: "DESC").take(MAX_DISPLAY_RELATED_PRODUCTS)
    
    # ↓メンズ商品。(出品中)かつカテゴリ「メンズ」の商品を３つのデータを取得。
    @mens_array = []
    @category = Category.find_by(name: "メンズ")
    @category.children.each do |child|
      child.children.each do |grand_child|
        # 空の配列にカテゴリ：メンズの孫IDと出品中IDのproductを格納
        @mens_array << Product.where(category_id: grand_child[:id],condition: 1)
      end
    end
    # 格納した配列をフラットにして、ランダムで3つ取り出す。
    @mens_flat = @mens_array.flatten
    @mens_samle = @mens_flat.sample(3)

    # ↓レディース商品。(出品中)かつカテゴリ「メンズ」の商品を３つのデータを取得。
    @ledies_array = []
    @category = Category.find_by(name: "レディース")
    @category.children.each do |child|
      child.children.each do |grand_child|
        # 空の配列にカテゴリ：メンズの孫IDと出品中IDのproductを格納
        @ledies_array << Product.where(category_id: grand_child[:id],condition: 1)
      end
    end
    # 格納した配列をフラットにして、ランダムで3つ取り出す。
    @ledies_flat = @ledies_array.flatten
    @ledies_samle = @ledies_flat.sample(3)



  end

  def new
    @product = Product.new
    @product.images.new
    @category_parent_array = ["---"]
    
    # データベースから、親カテゴリーのみ抽出し、配列化
    array = Category.where(ancestry: nil).pluck(:name)
    @category_parent_array.push(array)
    @category_parent_array.flatten!
   
    def get_category_children
      # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    end
      # 子カテゴリーが選択された後に動くアクション
    def get_category_grandchildren
      # 選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end
  end


  def create
    @product = Product.new(product_params)
    category_id_params
    if @product.save
      params[:images][:image].first(10).each do |a|
        @images = @product.images.create!(image: a, product_id: @product.id)
      end
      redirect_to root_path
    else
      redirect_to new_product_path unless @product.valid?
    end
  end

  def show
    # 商品が削除されているなら
    unless Product.where(id: params[:id]) == []
      @product = Product.find(params[:id])
      @comment = Comment.new
      @comments = @product.comments.includes(:user)
      @image_1 = Image.where(product_id: @product).first
      @image   = Image.where(product_id: @product)
    else
      redirect_to root_path
    end
  end


  def edit
    # 編集する商品を選択
    @parents = Category.where(ancestry:nil)
    @category = Category.find(@product[:category_id])
    
    # カテゴリーの情報
    @category_root = [@category.root.name]
    @category_parent = [@category.parent.name]
    @category_my = [@category.name, @category.id]

    # データベースから、親カテゴリーのみ抽出し、配列化
    def category_list
      @categories = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).siblings
    end
    # 選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    def get_category_children
      @category_children = Category.find(params[:parent_id]).children
    end
    # 子カテゴリーが選択された後に動くアクション
    def get_category_grandchildren
      #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path
  end
  
  def search
    @products = Product.search(params[:keyword])
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :description, :brand, :status, :postage_bearer, :shipping_area, :shipping_day, :price, :size, :category_id, :condition ,images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def category_id_params
    category = params.permit(:category_id)
    @product[:category_id] = category[:category_id]
  end

  def user_to_current_user?
    @product = Product.find(params[:id])
    if ! user_signed_in? || current_user.id != @product.user_id 
      redirect_to action: :index 
    end
  end


  private
  def require_login
    unless user_signed_in?
      flash[:error] = "ログイン状態でありません"
      redirect_to root_path
    end
  end
end
