class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: [:index]

  def index
    @card_address = CardAddress.new
  end

  def create
    @card_address = CardAddress.new(card_address_params)
    if @card_address.valid?
      pay_item
      @card_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def card_address_params
    params.require(:card_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    redirect_to root_path if (current_user.id == @item.user_id) || !user_signed_in? || !@item.order.nil?
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
