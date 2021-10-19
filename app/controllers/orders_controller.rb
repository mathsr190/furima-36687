class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @card_address = CardAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @card_address = CardAddress.new(card_address_params)
    if @card_address.valid?
      @card_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def card_address_params
    params.require(:card_address).permit(:number, :exp_month, :exp_year, :cvc, :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
