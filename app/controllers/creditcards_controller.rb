class CreditcardsController < ApplicationController
  require "payjp"
  before_action :require_login
  before_action :set_card

  def index
    
    # すでにクレジットカードが登録しているか？
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = Rails.application.credentials.payjp[:sk_test]
      # PAY.JPから顧客情報を取得する。
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      @card_info = customer.cards.retrieve(customer.default_card)
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの画像を表示するために、カード会社を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 

      # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def new
    @card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?    
    # カード番号は"4242424242424242"
    # 有効期限は未来の年月にする必要あり
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:sk_test]
    if params['payjpToken'].blank?
      render "new"
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, payjp_id: customer.id)
      if @card.save
        if request.referer&.include?("/registrations/step5")
          redirect_to controller: 'registrations', action: "step6"
        else
          redirect_to action: "index", notice:"支払い情報の登録が完了しました"
        end
      else
        render 'new'
      end
    end
  end

  def destroy     
    # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりcreateメソッドが複雑にならない。
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
    Payjp.api_key = Rails.application.credentials.payjp[:sk_test]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  def buy
    @product = Product.find(params[:product_id])
    # すでに購入されていないか？
    if @product.condition == 3
      redirect_back(fallback_location: root_path) 
    elsif @card.blank?
      # カード情報がなければ、買えないから戻す
      redirect_to new_user_creditcard_path(current_user.id)
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      # 購入者もいないし、クレジットカードもあるし、決済処理に移行
      Payjp.api_key = Rails.application.credentials.payjp[:sk_test]
      # 請求を発行
      Payjp::Charge.create(
      amount: @product.price,
      customer: @card.payjp_id,
      currency: 'jpy',
      )
      # 売り切れなので、productの情報をアップデートして売り切れにします。
      if @product.update(condition: 3)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      end
    end
  end

  private
  def require_login
    unless user_signed_in?
      flash[:error] = "ログイン状態でありません"
      redirect_to root_path
    end
  end

  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end
end
