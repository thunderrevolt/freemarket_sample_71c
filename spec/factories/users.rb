FactoryBot.define do

  factory :user do
    id              {"1"}
    nickname           {"aaa"}
    email              {"kkk@gmail.com"}
    first_name         {"阿部"}
    last_name          {"阿部"}
    first_name_kana    {"あべ"}
    last_name_kana     {"あべ"}
    tel                {"11122223333"}
    birthday           {"20000101"}
    password           {"0000000"}
    encrypted_password {"0000000"}
  end
end