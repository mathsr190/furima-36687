require 'rails_helper'

RSpec.describe CardAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @card_address = FactoryBot.build(:card_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '全項目(郵便番号,都道府県,市区町村,番地,建物名,電話番号)が入力されていたら購入できる' do
        expect(@card_address).to be_valid
      end
      it '建物名の入力がなくても購入できる' do
        @card_address.building = nil
        expect(@card_address).to be_valid
      end
    end
    context '商品購入できない場合' do
      it '郵便番号がないと保存できない' do
        @card_address.postal_code = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できない' do
        @card_address.postal_code = Faker::Number.number(digits: 7)
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '全角数字だと保存できない' do
        @card_address.postal_code = '１２３-４５６７'
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県がないと保存できない' do
        @card_address.prefecture_id = 0
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村がないと保存できない' do
        @card_address.city = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと保存できない' do
        @card_address.address = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がないと保存できない' do
        @card_address.phone_number = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンが入っていると保存できない' do
        @card_address.phone_number = '090-1234-5678'
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下だと保存できない' do
        @card_address.phone_number = '123456789'
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できない' do
        @card_address.phone_number = '123456789012'
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンがないと保存できない' do
        @card_address.token = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空だと保存できない' do
        @card_address.user_id = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @card_address.item_id = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
