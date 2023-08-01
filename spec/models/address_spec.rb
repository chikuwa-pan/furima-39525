require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
    @item = FactoryBot.create(:item) # Itemを生成して変数@itemに代入
    @purchase = FactoryBot.create(:purchase, item: @item) # @itemを関連付けたPurchaseを生成
    @address.purchase = @purchase # @addressと@purchaseを関連付ける
  end

  describe '住所登録' do
    context '住所登録できる' do
      it '郵便番号と都道府県と市区町村と番地と電話番号が存在すれば出品できる' do
        expect(@address).to be_valid
      end
    end

    context '出品できない' do
      it '注文情報が紐づいていない場合は登録できない' do
        @address.purchase = nil
        @address.valid?
        expect(@address.errors[:purchase]).to include("must exist")
      end

      it '郵便番号が空欄では登録できない' do
        @address.post_number = nil
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end

      it '郵便番号は3桁-4桁の形式でなければ登録できない' do
        @address.post_number = '1234567'
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end

      it '郵便番号は全角数字では登録できない' do
        @address.post_number = '１２３-４５６７'
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end

      it '郵便番号は漢数字では登録できない' do
        @address.post_number = '一二三-四五六七'
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end

      it '都道府県が未選択では登録できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors[:prefecture_id]).to be_empty
      end

      it '市区町村が空欄では登録できない' do
        @address.municipalities	 = nil
        @address.valid?
        expect(@address.errors[:municipalities]).to be_empty
      end

      it '番地が空欄では登録できない' do
        @address.address = nil
        @address.valid?
        expect(@address.errors[:address]).to be_empty
      end

      it '電話番号が空欄では登録できない' do
        @address.phone = nil
        @address.valid?
        expect(@address.errors[:phone]).to be_empty
      end

      it '電話番号は10桁未満では登録できない' do
        @address.phone = '090111222'
        @address.valid?
        expect(@address.errors[:phone]).to be_empty
      end

      it '電話番号は12桁以上では登録できない' do
        @address.phone = '090111122222'
        @address.valid?
        expect(@address.errors[:phone]).to be_empty
      end

      it '電話番号は全角数字では登録できない' do
        @address.phone = '０９０１１１１２２２２'
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end

      it '電話番号は漢数字では登録できない' do
        @address.phone = '一二三四五六八九十'
        @address.valid?
        expect(@address.errors[:post_number]).to be_empty
      end
    end
  end
end
