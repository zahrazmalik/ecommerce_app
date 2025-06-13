class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_and_product

  def create
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ActionCable.server.broadcast(
        "comments_#{@product.category.name}_#{@product.name}",
        comment: render_to_string(partial: "comments/comment", locals: { comment: @comment }, formats: [ :html ])
      )
      redirect_to category_product_path(@category.name, @product.name), notice: "Comment added!"
    else
      redirect_back fallback_location: category_product_path(@category.name, @product.name), alert: "Could not add comment."
    end
  end

  private

  def set_category_and_product
  @category = Category.find_by(name: params[:category_name])
  @product = @category&.products&.find_by(name: params[:product_name])

    unless @category && @product
      logger.error "Category or Product not found! category_name=#{params[:category_name]} product_name=#{params[:product_name]}"
      redirect_back fallback_location: root_path, alert: "Invalid category or product."
    end
  end

  # def set_category_and_product
  # @category = Category.find_by(name: params[:category_name])
  # @product = @category.products.find_by(name: params[:product_name]) if @category
  # end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
