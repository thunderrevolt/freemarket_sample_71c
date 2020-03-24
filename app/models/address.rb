class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping
  belongs_to_active_hash :day


  belongs_to :user, optional: true
  validates :first_name, :last_name, :first_name_kana, :last_name_kana,
            :zipcode, :number, presence: true

end
