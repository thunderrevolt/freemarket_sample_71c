# カテゴリー(親)の一覧取得
json.array! @categories do |category|
  json.id category.id
  json.name category.name
end 