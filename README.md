# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index|
### Association
- has_many :product
- has_ancestry

## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|ruby_first_name|string|null: false|
|ruby_last_name|string|null: false|
|birthday|integer|null: false|
|tel|integer|
### Association
- has_many  :products
- has_many  :cards
- has_many  :points
- has_many  :transfers
- has_many  :sells
- has_many  :buys
- has_many  :feelings
- has_many  :likes
- has_many  :like_product, through: :likes, source: :product
- has_many  :feeling_product, through: :feelings, source: :product

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|ruby_first_name|string|null: false|
|ruby_last_name|string|null: false|
|postal_code|integer|null: false|
|state|string|null: false|
|city|string|null: false|
|number|string|null: false|
|apartment|string|
|tel|integer|
|user_id|integer|null: false, foreign_key: true|
### Association  
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|string|null: false|
|category|string|null: false|
|brand|string|
|status|string|null: false|
|postage_bearer|string|null: false|
|shipping_area|string|null: false|
|shipping_day|string|null: false|
|price|string|null: false|
|size|string|
|user_id|integer|null: false, foreign_key: true|
|categories_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :category
- belongs_to :sell
- belongs_to :buy
- has_many   :images
- has_many   :feelings
- has_many   :likes
- has_many   :like_user, through: :likes, source: :user
- has_many   :feeling_user, through: :feelings, source: :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|product_id|integer|null:false, foreign_key: true|
### Association  
- belongs_to :product

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|month|string|null: false|
|year|string|null: false|
|pass|integer|null: false|
|user_id|integer|null:false, foreign_key: true|
### Association
- belongs_to :user

## pointsテーブル
|Column|Type|Options|
|------|----|-------|
|point|integer|null: false|
|user_id|integer|null:false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :transfer

## buysテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|status|string|null: false
### Association
- belongs_to :product
- belongs_to :user

## sellsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|status|string|null: false
### Association
- belongs_to :product
- belongs_to :user

## transfersテーブル
|Column|Type|Options|
|------|----|-------|
|point_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|bank|string|null: false|
|account|string|null: false|
|branch|string|null: false|
|number|integer|null: false|
|fist_name|string|null: false|
|last_name|string|null: false|
### Association
- has_many   :points
- belongs_to :user

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product
- belongs_to :user

## feelingsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product
- belongs_to :user

## noticesテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|