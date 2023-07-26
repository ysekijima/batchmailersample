class AddAgeToCats < ActiveRecord::Migration[6.0]
  def change
    add_column :cats, :age, :integer
  end
end
