class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, class_name: "User", foreign_key: "user_id"
  has_many :comments
  has_many :cart_items
  has_many :carts, through: :cart_items
end

Category.reflect_on_association(:products)
