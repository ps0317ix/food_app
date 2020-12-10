class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.text :name
      t.text :link
      t.text :area
      t.text :service

      t.timestamps
    end
  end
end
