require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @shipping_address = FactoryBot.build(:shipping_address)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '全項目入力されていたら購入できる' do
      end
    end
    context '商品購入できない場合' do
      it '入力ないと' do
      end
    end
  end
end
