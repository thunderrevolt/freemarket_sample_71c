require 'rails_helper'

describe User do
  describe '#create' do

    it "必須項目が入力されていれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ニックネームが入力されていなければ登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メアドが入力されていなければ登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが入力されていなければ登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください")
    end

    it "encrypted_passwordが入力されていなければ登録できない" do
      user = build(:user, encrypted_password: "")
      user.valid?
      expect(user.errors[:encrypted_password]).to include()
    end

    it "ニックネームは重複不可" do
      user1 = FactoryBot.create(:user, nickname: "taro")
      expect(FactoryBot.build(:user, nickname: nil, nickname: user1.nickname)).to_not be_valid
    end

    it "encrypted_passwordとpasswordが異なる場合保存できない" do 
      expect(FactoryBot.build(:user, password: nil, encrypted_password: "000000000")).to_not be_valid 
    end

    it "メールアドレスが重複していたら登録できない" do 
      user1 = FactoryBot.create(:user, email: "taro@example.com")
      expect(FactoryBot.build(:user, email: nil, email: user1.email)).to_not be_valid
    end

    it "名字が入力されていなければ登録できない" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください", "は不正な値です")
    end

    it "名前が入力されていなければ登録できない" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください", "は不正な値です")
    end

    it "名字（かな）が入力されていなければ登録できない" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "名前（かな）が入力されていなければ登録できない" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "生年月日が入力されていなければ登録できない" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "電話番号が入力されていなければ登録できない" do
      user = build(:user, tel: nil)
      user.valid?
      expect(user.errors[:tel]).to include("を入力してください", "は不正な値です")
    end
  end
end