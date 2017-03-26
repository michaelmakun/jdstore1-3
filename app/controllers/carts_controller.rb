class CartsController < ApplicationController
  def clean
    current_cart.clean!
    flash[:alert] = "已清空购物车"
    redirect_to carts_path
  end

  def checkout
    @order = Order.new
  end
end
