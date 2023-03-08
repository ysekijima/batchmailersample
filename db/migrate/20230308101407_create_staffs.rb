class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :email
      t.text :memo
      t.integer :fee

      t.timestamps
    end
  end
end
