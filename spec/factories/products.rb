FactoryBot.define do

  factory :product do
    name              {"商品"}
    description       {"これは商品です"}
    brand             {"シャネル"}
    status            {"未使用に近い"}
    postage_bearer    {"1"}
    shipping_area     {"1"}
    shipping_day      {"1"}
    size              {"s"}
    condition         {"1"}
    price             {"555"}
    user
    category
  end

end