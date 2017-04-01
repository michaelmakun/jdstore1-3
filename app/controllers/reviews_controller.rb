class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.product_id = @product.id

    if @review.save
      flash[:notice] = "添加评论成功"
      redirect_to @product
    else
      flash[:warning] = "评论没有内容"
      redirect_to :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :user_id, :product_id)
  end
end
