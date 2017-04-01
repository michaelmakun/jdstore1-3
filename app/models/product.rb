class Product < ApplicationRecord
  validates :title, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  belongs_to :category

  mount_uploader :image, ImageUploader

  searchkick

  acts_as_list

  has_many :groupships
  has_many :groups, through: :groupships, source: :group

  has_many :cart_items
  has_many :carts, through: :cart_items, source: :cart

  #product_favs means favourite products
  has_many :product_favs
  has_many :users, through: :product_favs, source: :user

  has_many :reviews, dependent: :destroy

  def favourite_product?(user)
    users.include?(user)
  end

  def add_favourite!(user)
    users << user
  end

  def cancel_favourite!(user)
    users.delete(user)
  end

end
