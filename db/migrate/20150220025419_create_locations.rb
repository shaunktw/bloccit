class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :address
      t.string :place_id
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
