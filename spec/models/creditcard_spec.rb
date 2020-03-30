require 'rails_helper'

describe Creditcard do
  describe '#create' do
    it "is invalid without user_id" do
     creditcard = Credutcard.new(user_id: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
     creditcard.valid?
     expect(user.errors[:nickname]).to include("can't be blank")
    end
  end
end