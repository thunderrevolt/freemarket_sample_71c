# bundle exec rspec spec/models/product_spec.rb

require 'rails_helper'
describe Product, type: :model do
  describe '#create' do

    it "全て揃っている時保存できる" do
      product = build(:product)
      expect(product).to be_valid
    end

    it "商品名が空だと登録できない事" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "説明が空だと登録できない事" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "商品の状態が空だと登録できない事" do
      product = build(:product, status: nil)
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end

    it "配送料の負担が空だと登録できない事" do
      product = build(:product, postage_bearer: nil)
      product.valid?
      expect(product.errors[:postage_bearer]).to include("を入力してください")
    end

    it "発送元の地域が空だと登録できない事" do
      product = build(:product, shipping_area: nil)
      product.valid?
      expect(product.errors[:shipping_area]).to include("を入力してください")
    end

    it "発送までの日数が空だと登録できない事" do
      product = build(:product, shipping_day: nil)
      product.valid?
      expect(product.errors[:shipping_day]).to include("を入力してください")
    end

    it "販売価格が空だと登録できない事" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    it "category_idが空だと登録できない事" do
      product = build(:product, category_id: nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end

    it "user_idが空だと登録できない事" do
      product = build(:product, user_id: nil)
      product.valid?
      expect(product.errors[:user]).to include("を入力してください")
    end

    it "nameの文字が40文字以上の場合登録できない事" do
      product = build(:product, name: "a" * 41)
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "nameの文字が40文字以上の場合登録できる事" do
      product = build(:product, name: "a" * 39)
      expect(product).to be_valid
    end

    it "商品説明の文字が1000文字の場合登録できる事" do
      product = build(:product, description: "a" * 1000)
      expect(product).to be_valid
    end

    it "商品説明の文字が1000文字以上の場合登録できない事" do
      product = build(:product, description: "a" * 1001)
      product.valid?
      expect(product.errors[:description]).to include("は1000文字以内で入力してください")
    end

    it "値段が9999999円以上の時登録できない" do
      product = build(:product, price: 10000000)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "値段が9999999円以上の時登録できる" do
      product = build(:product, price: 9999999)
      expect(product).to be_valid
    end

    it "値段が299円の時登録できない" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "値段が300円の時登録できる" do
      product = build(:product, price: 300)
      expect(product).to be_valid
    end

    it "brandが無くても保存できる" do
      product = build(:product, brand: "")
      expect(product).to be_valid
    end


  end
  # update
  describe '#update' do
    it "全て揃っている時保存できる" do
      product = build(:product)
      expect(product).to be_valid
    end

    it "商品名が空だと登録できない事" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "説明が空だと登録できない事" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "商品の状態が空だと登録できない事" do
      product = build(:product, status: nil)
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end

    it "配送料の負担が空だと登録できない事" do
      product = build(:product, postage_bearer: nil)
      product.valid?
      expect(product.errors[:postage_bearer]).to include("を入力してください")
    end

    it "発送元の地域が空だと登録できない事" do
      product = build(:product, shipping_area: nil)
      product.valid?
      expect(product.errors[:shipping_area]).to include("を入力してください")
    end

    it "発送までの日数が空だと登録できない事" do
      product = build(:product, shipping_day: nil)
      product.valid?
      expect(product.errors[:shipping_day]).to include("を入力してください")
    end

    it "販売価格が空だと登録できない事" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

    it "category_idが空だと登録できない事" do
      product = build(:product, category_id: nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end

    it "user_idが空だと登録できない事" do
      product = build(:product, user_id: nil)
      product.valid?
      expect(product.errors[:user]).to include("を入力してください")
    end

    it "nameの文字が40文字以上の場合登録できない事" do
      product = build(:product, name: "a" * 41)
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "nameの文字が40文字以上の場合登録できる事" do
      product = build(:product, name: "a" * 39)
      expect(product).to be_valid
    end

    it "値段が9999999円以上の時登録できない" do
      product = build(:product, price: 10000000)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "値段が9999999円以上の時登録できる" do
      product = build(:product, price: 9999999)
      expect(product).to be_valid
    end

    it "値段が299円の時登録できない" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "値段が300円の時登録できる" do
      product = build(:product, price: 300)
      expect(product).to be_valid
    end

    it "brandが無くても保存できる" do
      product = build(:product, brand: "")
      expect(product).to be_valid
    end
  end
end