class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :comments
  has_one :address
  validates :nickname,
            presence: true,
            length: { maximum: 255 }
            
  validates :first_name, :last_name,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[一-龥]+\z/ }

  validates :first_name_kana, :last_name_kana,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[ぁ-んー－]+\z/ }

  validates :birthday, 
            presence: true

  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :tel, 
            presence: true,
            format: { with: VALID_PHONE_REGEX }

  validates :password,
            presence: true, 
            length: { minimum: 7 }

  VALID_EMAIL_REGEX = /\A[\x21-\x3f\x41-\x7e]+@(?:[-a-z0-9]+\.)+[a-z]{2,}\z/i
  validates :email,
            length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
end
