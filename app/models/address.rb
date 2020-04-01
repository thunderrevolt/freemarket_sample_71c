class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping
  belongs_to_active_hash :day

  belongs_to :user, optional: true
  validates :first_name, :last_name,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[一-龥]+\z/ }

  validates :first_name_kana, :last_name_kana,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[ぁ-んー－]+\z/ }

  validates :zip1, 
            presence: true,
            length: { maximum: 3 }
  
  validates :zip2,
            presence: true,
            length: { maximum: 4 }
  
  validates :address1, :address2,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[ぁ-んァ-ン一-龥]/ }

  validates :street_address,
            presence: true,
            length: { maximum: 255 }

  validates :apartment,
            length: { maximum: 255 }
end
