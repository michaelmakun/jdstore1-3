class ProductFav < ApplicationRecord
  #product_favs means favourite products
  belongs_to :user
  belongs_to :product
end
