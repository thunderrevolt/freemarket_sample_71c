class CommentsController < ApplicationController
  def create
    comment = Comment.new(product_params)
    if comment.save
      redirect_to products_path(comment.product.id), notice: '投稿OK'
    else
      render "product/show",notice: '投稿に失敗しました'
    end
  end
  

  private
  def product
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])  
  end
end
