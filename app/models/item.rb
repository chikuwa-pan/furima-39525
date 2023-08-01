class Item < ApplicationRecord
  validates :image, presence: true

  validates :title, 
            :description, 
            :category_id, 
            :condition_id, 
            :postage_id, 
            :prefecture_id, 
            :shipping_day_id, 
            presence: true

  validates :price, presence: true,
                    numericality: { 
                      only_integer: true, 
                      greater_than_or_equal_to: 300, 
                      less_than_or_equal_to: 999999 }

  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :category
    belongs_to_active_hash :condition
    belongs_to_active_hash :postage
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :shipping_day

    validates :category_id, 
              :condition_id, 
              :postage_id, 
              :prefecture_id, 
              :shipping_day_id, 
              exclusion: { in: [1] }

  def was_attached?
    self.image.attached?
  end
end