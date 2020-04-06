# カテゴリー(子)の一覧取得
json.array! @category_children do |child|
  json.id child.id
  json.name child.name
end