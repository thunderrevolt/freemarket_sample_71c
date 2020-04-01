class Day < ActiveHash::Base
  include ActiveHash::Associations
  belongs_to :addressz
end