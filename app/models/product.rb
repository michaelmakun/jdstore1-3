class Product < ApplicationRecord
  validates :title, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  belongs_to :category
  mount_uploader :image, ImageUploader

  has_many :groupships
  has_many :groups, through: :groupships, source: :group

  has_many :cart_items
  has_many :carts, through: :cart_items, source: :cart
end
