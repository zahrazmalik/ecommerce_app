class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    product = Product.find(cart_item_params[:product_id])
    quantity = cart_item_params[:quantity].to_i
    quantity = 1 if quantity <= 0

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += quantity
    cart_item.price = product.price

    if cart_item.save
      redirect_to cart_path(@cart), notice: "Added to cart!"
    else
      redirect_back fallback_location: root_path, alert: "Could not add to cart."
    end
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path(@cart), notice: "Item removed from cart."
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def cart_item_params
    params.permit(:product_id, :quantity)
  end
end
