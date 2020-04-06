class UsersController < ApplicationController
  before_action :require_login, only: [:show, :logout]

  def index
  end


  def show
    @user = User.find(params[:id])
    @products = @user.products
  end

  def logout
  end

  private
  def require_login
    unless user_signed_in?
      flash[:error] = "ログイン状態でありません"
      redirect_to root_path
    end
  end
  
end
