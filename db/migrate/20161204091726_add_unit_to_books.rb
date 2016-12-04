class AddUnitToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :unit, :string
  end
end
