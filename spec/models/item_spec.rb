require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    context '出品できる' do
      before do
        @item = FactoryBot.build(:item)
      end

      it '商品画像と商品名と商品の説明とカテゴリーと商品の状態と配送料の負担と発送元の地域と発送までの日数と販売価格が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない' do
      before do
        @item = Item.new
      end

      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end

      it 'titleが空では登録できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors[:title]).to include("can't be blank")
      end

      it 'descriptionが空では登録できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'category_id が空では登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end

      it 'condition_id が空では登録できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors[:condition_id]).to include("can't be blank")
      end

      it 'postage_idが空では登録できない' do
        @item.postage_id = nil
        @item.valid?
        expect(@item.errors[:postage_id]).to include("can't be blank")
      end

      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'shipping_day_id が空では登録できない' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors[:shipping_day_id]).to include("can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it 'priceが¥300未満だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include("must be greater than or equal to 300")
      end

      it 'priceが¥10,000,000以上だと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors[:price]).to include("must be less than or equal to 999999")
      end

      it 'priceが全角では登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors[:price]).to include("is not a number")
      end

      it 'priceが整数でないと登録できない' do
        @item.price = 1000.5
        @item.valid?
        expect(@item.errors[:price]).to include("must be an integer")
      end
    end
  end
end
