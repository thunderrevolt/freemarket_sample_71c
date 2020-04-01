class Prefecture < ActiveHash::Base
  include ActiveHash::Associations
  belongs_to :address
end