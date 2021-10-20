class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, only: [:index]

  def index
    @card_address = CardAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @card_address = CardAddress.new(card_address_params)
    @item = Item.find(params[:item_id])
    if @card_address.valid?
      pay_item
      @card_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def card_address_params
    params.require(:card_address).permit(:number, :exp_month, :exp_year, :cvc, :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if (user_signed_in? && current_user.id == @item.user_id) || !user_signed_in?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: card_address_params[:token],
      currency: 'jpy'
    )
  end
end
