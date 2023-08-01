require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  describe 'モデルのバリデーション' do
    it 'userとitemが存在する場合、正常にpurchaseを作成できること' do
      purchase = FactoryBot.build(:purchase, user: @user, item: @item)
      expect(purchase).to be_valid
    end

    it 'userが存在しない場合、purchaseを作成できないこと' do
      purchase = FactoryBot.build(:purchase, user: nil, item: @item)
      expect(purchase).not_to be_valid
      expect(purchase.errors[:user]).to include('must exist')
    end

    it 'itemが存在しない場合、purchaseを作成できないこと' do
      purchase = FactoryBot.build(:purchase, user: @user, item: nil)
      expect(purchase).not_to be_valid
      expect(purchase.errors[:item]).to include('must exist')
    end
  end

  describe 'モデルの関連付け' do
    it 'userとitemとの関連付けが正しく機能していること' do
      purchase = FactoryBot.create(:purchase, user: @user, item: @item)

      expect(purchase.user).to eq(@user)
      expect(purchase.item).to eq(@item)
    end
  end
end
