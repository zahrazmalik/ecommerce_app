class CategoriesController < ApplicationController
  def index
    puts "Loaded CategoriesController#index"
    @categories = Category.all
  end

  def show
    @category = Category.find_by(name: params[:name])
    @products = @category.products
  end
end
