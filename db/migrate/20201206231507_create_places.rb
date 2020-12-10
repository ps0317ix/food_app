class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.text :name
      t.text :link
      t.text :service

      t.timestamps
    end
  end
end
