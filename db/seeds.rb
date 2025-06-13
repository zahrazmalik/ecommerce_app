# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create Categories
electronics = Category.create!(name: "electronics")
clothing = Category.create!(name: "clothing")

# Create Users
admin = User.create!(name: "Zahra", email: "zahra@example.com", password: "password", role: "admin")
seller = User.create!(name: "Ali", email: "ali@example.com", password: "password", role: "seller")
buyer = User.create!(name: "Kakkamanna", email: "kakkamanna@example.com", password: "password", role: "buyer")

# Create Products
Product.create!(name: "iphone-15", description: "Latest Apple iPhone", price: 999.99, category: electronics, user: seller)
Product.create!(name: "t-shirt", description: "Comfortable cotton t-shirt", price: 19.99, category: clothing, user: seller)

# Create Comments
Comment.create!(body: "Great product!", user: buyer, product: Product.first)
