class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, foreign_key: "user_id"
  has_many :comments
  has_one :cart, dependent: :destroy

  def admin?
    role == "admin"
  end

  def seller?
    role == "seller"
  end

  def buyer?
    role == "buyer"
  end

    private
  def create_cart
    Cart.create(user: self)
  end
end
