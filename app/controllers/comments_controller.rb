class CommentsController < ApplicationController
  def create
    comment = Comment.new(product_params)
    if comment.save
      redirect_to product_path(comment.product.id), notice: '投稿OK'
    else
      redirect_to product_path(comment.product.id)
    end
  end
  

  private
  def product_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])  
  end
end
