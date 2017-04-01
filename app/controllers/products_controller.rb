class ProductsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @products = Product.all.order("position ASC")

    if params[:favourite] == "success"
      @products = current_user.products
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.all.order("created_at DESC")
    @review = Review.new

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).present? ? @reviews.average(:rating).round(2) : 0
    end
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "成功将#{@product.title}加入购物车成功"
    else
      flash[:warning] = "您的购物车内已有此物品"
    end
    redirect_to :back
  end

  def favourite
    @product = Product.find(params[:id])
    # if !current_user.favourite_product?(@product)
    #   current_user.add_favourite!(@product)
    #   flash[:notice] = "成功将#{@product.title}加入收藏"
    # else
    #   flash[:warning] = "您已收藏过本产品"
    # end
    # redirect_to :back
    if @product.add_favourite!(current_user)
      flash[:notice] = "加入收藏成功"
    else
      flash[:warning] = "您已收藏过本产品"
    end
    redirect_to :back
  end

  def unfavourite
    @product = Product.find(params[:id])
    # if current_user.favourite_product?(@product)
    #   current_user.cancel_favourite!(@product)
    #   flash[:notice] = "取消收藏#{@product.title} "
    # else
    #   flash[:warning] = "没有收藏，不用取消"
    # end
    # redirect_to :back
    if @product.cancel_favourite!(current_user)
      flash[:alert] = "取消收藏"
    else
      flash[:warning] = "没有收藏，不用取消"
    end
    redirect_to :back
  end
end
