class AddRelations < ActiveRecord::Migration[6.0]
  def change
    add_reference :cats, :shop
    add_reference :staffs, :shop

  end
end
