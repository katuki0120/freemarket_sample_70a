class Product < ApplicationRecord
  enum dealing_status: { good: 0, normal: 1, bad: 2 }
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category
  has_many :favorite_products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images
  
  validates :images, presence:true, length:{manimum: 1, maximum: 10}
  validates :name, :product_introduction, :category_id, :size_id, :product_condition_id,:delivery_fee_id, :prefecture_id, :delivery_days_id, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :product_condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_days
end