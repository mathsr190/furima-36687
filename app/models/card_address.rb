class CardAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number,
              numericality: format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid' }
    validates :token
  end
  def save
    @order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
                           building: building, phone_number: phone_number, order_id: @order.id)
    @item = Item.find(item_id)
    @item.order_id = @order.id
    @item.save
  end
end
