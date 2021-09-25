class Item < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
  end
  belongs_to :user
  has_one_attached :image
end
