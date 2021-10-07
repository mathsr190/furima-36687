class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @order = Order.new(order_params)

  end

  def create
  end

  private
  def order_params
    params.permit(:number, :exp_month, :exp_year, :cvc)
  end

  def card_params

  end
  def shipping_address_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], order_id: @order.id)
  end
end
