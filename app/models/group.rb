class Group < ApplicationRecord
  has_many :products, through: :groupships, source: :product
  has_many :groupships
end
