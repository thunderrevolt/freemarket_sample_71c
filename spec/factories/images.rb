FactoryBot.define do
  factory :image do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/images/test_image.jpg")}
    product
  end
end