class CardAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :number, :exp_month, :exp_year, :cvc, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :number
    validates :exp_month
    validates :exp_year
    validates :cvc
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number, numericality: {only_integer: true, greater_than_or_equal_to: 1000000000, less_than_or_equal_to: 99999999999, message: 'is invalid'}
  end
  def save
    @order = Order.create(user_id: user_id, item_id: item_id)
    Card.create(number: number, exp_month: exp_month, exp_year: exp_year, cvc: cvc, order_id: @order.id)
    binding.pry
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: @order.id)
  end


end