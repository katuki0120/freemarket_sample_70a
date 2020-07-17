class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :credit_card, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :destination, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :nickname,                         presence: true
  validates :password,                         presence: true, length: { in: 7..128 }
  validates :family_name, :first_name,           presence: true
  validates :family_name_kana, :first_name_kana, presence: true,
                                               format: {
                                               with: /\A[ァ-ヶー－]+\z/,
                                               }
  validates :email,                             presence: true, length: { maximum: 255 },
                                                format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :postal_code, :prefecture, :city, :address, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
end
