# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Users テーブル

| Column        | Type   | Options                             |
| ------------- | ------ | ----------------------------------- |
| nickname      | string | null: false                         |
| emailadress   | string | null: false, unque:true, index:ture |
| user_password | string | null: false                         |

### Association

- has_one :credit_card dependent: :destroy
- has_one :profile dependent: :destroy
- has_one :address dependent: :destroy
- has_many :comments dependent: :destroy
- has_one :destination dependent: :destroy
- has_many :favorite_products dependent: :destroy
- has_many :products dependent:destroy

## Profiles テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| family_name      | string     | null: false                    |
| first_name       | string     | null: false                    |
| family_name_kana | string     | null: false                    |
| first_name_kana  | string     | null: false                    |
| Birthday         | date       | null: false                    |
| introduction     | text       |
| user_id          | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## Credit_Cards テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user_id         | references | null: false, foreign_key: true |
| card_number     | integer    | null: false, unique: true      |
| expiration_date | integer    | null: false                    |
| security_code   | integer    | null: false                    |

### Association

- belongs_to :user

## Address テーブル

| Column                       | Type       | Options                        |
| ---------------------------- | ---------- | ------------------------------ |
| user_id                      | references | null: false, foreign_key: true |
| destination_family_name      | string     | null: false                    |
| destination_first_name       | string     | null: false                    |
| destination_family_name_kana | string     | null: false                    |
| destination_first_name_kana  | string     | null: false                    |
| postal_code                  | integer    | null: false                    |
| prefecture(use gem)          | integer    | null: false                    |
| prefecture(don't user gem)   | string     | null: false                    |
| city                         | string     | null: false                    |
| address                      | string     | null: false                    |
| building_name                | string     |                                |
| phone_namber                 | integer    | null: false, unque:true        |

### Association

- belongs_to :user

## Destination テーブル

| Column                       | Type       | Options                        |
| ---------------------------- | ---------- | ------------------------------ |
| user_id                      | references | null: false, foreign_key: true |
| destination_family_name      | string     | null: false                    |
| destination_first_name       | string     | null: false                    |
| destination_family_name_kana | string     | null: false                    |
| destination_first_name_kana  | string     | null: false                    |
| postal_code                  | integer    | null: false                    |
| prefecture(use gem)          | integer    | null: false                    |
| prefecture(don't user gem)   | string     | null: false                    |
| city                         | string     | null: false                    |
| address                      | string     | null: false                    |
| building_name                | string     |                                |
| phone_namber                 | integer    | null: false, unque:true        |

### Association

- belongs_to :user

## Comments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | references | null: false,foreign_key: true  |
| product_id | references | null: false,foreign_key: true  |
| comment    | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :product

## Favorite_productsテーブル

|Column    |Type      |Options                        |
|----------|----------|-------------------------------|
|user_id   |references|null: false, foreign_key: true |
|Product_id|references|null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product

## Products テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user_id              | references |null: false, foreign_key: true | 
| name                 | string     | null: false                    |
| price                | integer    | null: false                    |
| category_id          | references | null: false, foreign_key: true |
| brand_id             | references | null: false, foreign_key: true |
| product_condition_id | references | null: false, foreign_key: true |
| size_id              | references | null: false, foreign_key: true |
| dealing_status       | enum       | null: false                    |
| shipment_id          | references | null: false, foreign_key: true |
| product_introduction | text       |

### Association

- belongs_to :user
- belongs_to :brand
- belongs_to :size
- belongs_to :category
- belongs_to :shipment
- belong_to :product_condition
- has_many :favorite_products dependent: :destroy
- has_many :comments dependent: : destory
- has_many :product_imgs

## Product_imgsテーブル

|Column    |Type      |Options                       |
|----------|----------|------------------------------|
|Product_id|references|null: false, foreign_key: true|
|image     |string    |null: false                   |

### Association
- belong_to :product

## Categoriesテーブル

|Column  |Type  |Options    |
|--------|------|-----------|
|name    |string|null: false|
|ancestry|string|null: false|

### Association
- has_many :products

## Sizesテーブル

|Column|Type  |Options    |
|------|------|-----------|
|size  |string|null: false|

### Association

- has_many :products

## Brandsテーブル

|Column|Type  |Options    |
|------|------|-----------|
|name  |string|           |

### Association

- has_many :products

## Product_conditionsテーブル

|Column             |Type  |Options     |
|-------------------|------|------------|
|product_condition |string|null: false  |

### Association
- has_many :products

## Shipmentテーブル

|Column   |Type  |Options    |
|---------|------|-----------|
|shipment |string|null: false|

### Association
- has_many :products