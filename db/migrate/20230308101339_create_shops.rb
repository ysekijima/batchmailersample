class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.text :memo
      t.integer :rent

      t.timestamps
    end
  end
end
