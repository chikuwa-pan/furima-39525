class AddFirstnamekanaToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name_kana, :string
  end
end
