class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_category
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def show
    authorize @product
    @comments = @product.comments.where(parent_id: nil).includes(:replies)
  end

  def new
    @product = @category.products.build
    authorize @product
  end

  def create
    @product = @category.products.build(product_params)
    @product.seller = current_user
    authorize @product

    if @product.save
      redirect_to category_product_path(@category.name, @product.name), notice: "Product created."
    else
      render :new
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to category_product_path(@category.name, @product.name), notice: "Product updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to category_path(@category.name), notice: "Product deleted."
  end

  private

  def set_category
    @category = Category.find_by!(name: params[:category_name])
  end

  def set_product
    @product = @category.products.find_by!(name: params[:name])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
