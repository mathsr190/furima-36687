class ItemsController < ApplicationController
  before_action :move_to_login, only: :new
  def index
  end

  def new
    @items = Item.new
  end

  def create

  end

  private
  def item_params
    params.require(:item).permit(:image,:name,:info,:category_id,:sales_status_id,:shipping_fee_status_id,:prefecture_id,:scheduled_delivery_id,:price).merge(user_id: current_user.id)
  end

  def move_to_login
    unless user_signed_in?
      redirect_to authenticate_user!
    end
  end
end
