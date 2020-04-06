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
- has_many :product, dependent: :destroy
- has_ancestry

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product
- belongs_to :user

## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|integer|null: false|
|tel|integer|
### Association
- has_many  :products
- has_many  :creditcards, dependent: :destroy
- has_many  :likes, dependent: :destroy
- has_many  :comments, dependent: :destroy
- has_many  :like_product, through: :likes, source: :product
- belongs_to:addresses, dependent: :destroy

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|zip1|integer|null: false|
|zip2|integer|null: false|
|address1|string|null: false|
|address2|string|null: false|
|street_address|string|null: false|
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
|price|integer|limit: 6|null: false|
|size|string|
|condition|integer|
|user_id|integer|null: false, foreign_key: true|
|categories_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :category
- has_many   :comments, dependent: :destroy
- has_many   :images, dependent: :destroy
- has_many   :likes, dependent: :destroy
- has_many   :like_user, through: :likes, source: :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|product_id|integer|null:false, foreign_key: true|
### Association  
- belongs_to :product

## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|payjp_id|string|null:false|
|user_id|integer|null:false, foreign_key: true|
### Association
- belongs_to :user

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product
- belongs_to :user

[merukari_App　ER図 - シート1 (4).pdf](https://github.com/thunderrevolt/freemarket_sample_71c/files/4426427/merukari_App.ER.-.1.4.pdf)