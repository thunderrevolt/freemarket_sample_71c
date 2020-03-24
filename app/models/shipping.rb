class Shipping < ActiveHash::Base
  include ActiveHash::Associations
  belongs_to :address
end