class ItemsController < ApplicationController
  before_action :move_to_login, only: :new
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render new_item_path
    end
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
