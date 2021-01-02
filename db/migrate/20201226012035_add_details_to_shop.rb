class AddDetailsToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :img, :string
    add_column :shops, :jenre, :string
  end
end
