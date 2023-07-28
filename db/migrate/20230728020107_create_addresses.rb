class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :purchase,      null: false, foreign_key: true
      t.string :post_number,       null: false
      t.string :prefecture_id,     null: false
      t.string :municipalities,    null: false
      t.string :address,           null: false
      t.string :building
      t.integer :phone,            null: false
      t.timestamps
    end
  end
end
