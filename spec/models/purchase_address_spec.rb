require 'rails_helper'
require 'gimei'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user_id = FactoryBot.create(:user)
    @item_id = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user_id, item_id: @item_id)
  end

  describe '送付先住所の保存' do
    context '登録できる' do
      it '全ての情報が正しければ購入できる' do
        expect(@purchase_address).to be_valid
      end

      it '建物名は空でも保存できる' do
        @purchase_address.building = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '登録できない' do
      it '郵便番号が空欄では登録できない' do
        @purchase_address.post_number  = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post number can't be blank")
      end

      it '郵便番号は3桁-4桁の形式でなければ登録できない' do
        @purchase_address.post_number = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors[:post_number]).to include("must be in the format of XXX-XXXX(three digits, hyphen, and four digits).")
      end

      it '郵便番号は半角数字以外は登録できない' do
        @purchase_address.post_number = '１２３-４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors[:post_number]).to include("must be in the format of XXX-XXXX(three digits, hyphen, and four digits).")
      end

      it '都道府県が未選択では登録できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors[:prefecture_id]).to include("is reserved")
      end

      it '市区町村が空欄では登録できない' do
        @purchase_address.municipalities = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '番地が空欄では登録できない' do
        @purchase_address.address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空欄では登録できない' do
        @purchase_address.phone = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone must be 10 or 11 digits without hyphens.")
      end

      it '電話番号は半角数字以外は登録できない' do
        @purchase_address.phone = '０９０１１１１２２２２'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone must be 10 or 11 digits without hyphens.")
      end

      it '電話番号は10桁未満では登録できない' do
        @purchase_address.phone = '090111222'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone must be 10 or 11 digits without hyphens.")
      end

      it '電話番号は12桁以上では登録できない' do
        @purchase_address.phone = '090111122222'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone must be 10 or 11 digits without hyphens.")
      end

      it 'tokenが空欄では登録できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    
      it 'tokenが正しくないと登録できない' do
        @purchase_address.token = 'invalid_token'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token is invalid")
      end

      it 'item_idが紐付いていないと登録できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが紐付いていないと登録できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
