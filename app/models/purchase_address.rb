class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_number, :prefecture_id, :municipalities, :address, :building, :phone, :purchase_id, :token, :price

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_number, format: { with: /\A\d{3}[-]\d{4}\z/, message: "must be in the format of XXX-XXXX(three digits, hyphen, and four digits)." }
    validates :prefecture_id, numericality: { greater_than: 1, message: "must be selected" }
    validates :municipalities
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: "must be 10 or 11 digits without hyphens." }
    validates :token, format: { with: /\Atok_[a-zA-Z0-9]+\z/ }
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