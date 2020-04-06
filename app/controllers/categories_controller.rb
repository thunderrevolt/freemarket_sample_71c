class CategoriesController < ApplicationController
  def index
  end

  def show
    @products = []
    @category = Category.find(params[:id])

    # カテゴリーの孫でなければ！
    unless @category.children == []
      @category_children = @category.children

      @category_children.each do |child|
        # カテゴリーが子なら商品検索し配列に入れる
        if child.children == []
          @products << Product.where(category_id: child[:id])
        else # カテゴリーが親なら孫達で検索し配列に入れる
          child.children.each do |grand_child|
            @products << Product.where(category_id: grand_child[:id])
          end
        end
      end
    else
      # カテゴリーが孫なら商品検索し配列に入れる
      @products << Product.where(category_id: @category[:id])
    end
    # フラットにする
    @products = @products.flatten
  end
end
