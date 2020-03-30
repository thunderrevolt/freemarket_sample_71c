require 'rails_helper'

describe Creditcard do
  describe '#create' do
    it "is invalid without payjp_id" do
     creditcard = Creditcard.new(user_id: "1", payjp_id: "")
     creditcard.valid?
     expect(creditcard.errors[:payjp_id]).to include("を入力してください")
    #  エラー文が日本語表記になっている。デフォルトは英語で『can't be blank』
    end
  end

  describe '#create' do
    it "is invalid without user_id" do
     creditcard = Creditcard.new(user_id: "", payjp_id: "aaaaaaaaaaaaaaaaaa")
     creditcard.valid?
     expect(creditcard.errors[:user_id]).to include("を入力してください")
    end
  end
end