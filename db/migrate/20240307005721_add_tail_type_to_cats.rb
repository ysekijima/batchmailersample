class AddTailTypeToCats < ActiveRecord::Migration[6.0]
  def change
    add_column :cats, :tail_type, :string, comment: '尻尾タイプ'
  end
end
