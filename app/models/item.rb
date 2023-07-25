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
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :category, numericality: { other_than: 1 }
    belongs_to_active_hash :condition, numericality: { other_than: 1 }
    belongs_to_active_hash :postage, numericality: { other_than: 1 }
    belongs_to_active_hash :prefecture, numericality: { other_than: 1 }
    belongs_to_active_hash :shipping_day, numericality: { other_than: 1 }

  def was_attached?
    self.image.attached?
  end
end