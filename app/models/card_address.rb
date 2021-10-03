class CardAddress
  include ActiveModel::Model
  attr_accessor :number, :exp_month, :exp_year, :cvc, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :order_id

  with_options presence: true do
    validates :number
    validates :exp_month
    validates :exp_year
    validates :cvc
    validates :postal_code,  format: format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number, numericality: {only_integer: true, greater_than_or_equal_to: 1000000000, less_than_or_equal_to: 99999999999, message: 'is invalid'}
  end


end