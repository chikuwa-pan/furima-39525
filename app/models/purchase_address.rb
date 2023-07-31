class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_number, :prefecture_id, :municipalities, :address, :building, :phone, :purchase_id, :token, :price

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_number, format: { with: /\A\d{3}[-]\d{4}\z/, message: "3桁の数字-4桁の数字の形式で入力してください" }
    validates :prefecture_id, exclusion: { in: [1] }
    validates :municipalities
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: "ハイフンなし10桁もしくは11桁の形式で入力してください" }
  end

    def save
      # 購入情報を保存し、変数purchaseに代入する
      @purchase = Purchase.create(user_id: user_id, item_id: item_id)
      # 住所を保存する
      # purchase_idには、変数purchaseのidと指定する
      Address.create(post_number: post_number, 
                    prefecture_id: prefecture_id, 
                    municipalities: municipalities, 
                    address: address, 
                    building: building,
                    phone: phone,
                    purchase_id: @purchase.id)
    end
end