require 'rails_helper'

describe Address do
  describe '#create' do

    it "必須項目が入力されていれば登録できる" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "名字が入力されていなければ登録できない" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください", "は不正な値です")
    end

    it "名前が入力されていなければ登録できない" do
      address= build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください", "は不正な値です")
    end

    it "名字（かな）が入力されていなければ登録できない" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "名前（かな）が入力されていなければ登録できない" do
      address = build(:address, last_name_kana: nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "番地が入力されていなければ登録できない" do
      address = build(:address, street_address: nil)
      address.valid?
      expect(address.errors[:street_address]).to include("を入力してください")
    end

    it "住所１が入力されていなければ登録できない" do
      address = build(:address, address1: nil)
      address.valid?
      expect(address.errors[:address1]).to include("を入力してください", "は不正な値です")
    end

    it "住所２が入力されていなければ登録できない" do
      address = build(:address, address2: nil)
      address.valid?
      expect(address.errors[:address2]).to include("を入力してください", "は不正な値です")
    end

    it "郵便番号１が入力されていなければ登録できない" do
      address = build(:address, zip1: nil)
      address.valid?
      expect(address.errors[:zip1]).to include("を入力してください")
    end

    it "郵便番号２が入力されていなければ登録できない" do
      address = build(:address, zip2: nil)
      address.valid?
      expect(address.errors[:zip2]).to include("を入力してください")
    end
  end
end