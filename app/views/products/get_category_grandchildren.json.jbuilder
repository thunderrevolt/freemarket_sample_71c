# カテゴリー(孫)の一覧取得
json.array! @category_grandchildren do |grandchild|
  json.id grandchild.id
  json.name grandchild.name
end 