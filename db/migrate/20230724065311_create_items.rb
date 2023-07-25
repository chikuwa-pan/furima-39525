class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user,         null: false, foreign_key: true
      t.string :title,            null: false
      t.text :description,        null: false
      t.integer :condition_id,    null: false
      t.integer :postage_id,      null: false
      t.integer :prefecture_id,   null: false
      t.integer :shipping_day_id, null: false
      t.integer :price,           null: false
      t.timestamps
    end
  end
end
