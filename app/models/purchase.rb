class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  validates :prefecture_id, 
            :municipalities	, 
            :address, 
            presence: true

  validates :post_number, presence: true, 
            format: { with: /\A\d{3}[-]\d{4}\z/, message: "3桁の数字-4桁の数字の形式で入力してください" }

  validates :phone, presence: true,
            format: { with: /^\d{10}$|^\d{11}$/, message: "ハイフンなし10桁もしくは11桁の形式で入力してください" }

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture

    validates :prefecture_id, exclusion: { in: [1] }
end
