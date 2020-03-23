class CommentsController < ApplicationController
  def create
    comment = Comment.create(product_params)
    redirect_to products_path(comment.product.id)
  end

  private
  def product
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])  
  end
end
