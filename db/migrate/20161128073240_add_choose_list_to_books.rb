class AddChooseListToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :choose_list, :string
  end
end
