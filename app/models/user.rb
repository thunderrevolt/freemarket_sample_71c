class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  has_many :products
  has_many :comments
  has_one :address
  validates :nickname, :first_name, :last_name,
            :first_name_kana, :last_name_kana,
            :birthday, :tel, presence: true
end
