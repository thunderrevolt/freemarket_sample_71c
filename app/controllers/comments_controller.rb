class CommentsController < ApplicationController
  before_action :require_login
  def create
    comment = Comment.new(product_params)
    if comment.save
      redirect_to product_path(comment.product.id), notice: '投稿OK'
    else
      redirect_to product_path(comment.product.id)
    end
  end
  

  private
  def require_login
    unless user_signed_in?
      flash[:error] = "ログイン状態でありません"
      redirect_to root_path
    end
  end

  def product_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, product_id: params[:product_id])  
  end
end
