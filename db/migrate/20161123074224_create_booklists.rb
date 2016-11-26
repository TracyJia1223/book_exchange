class CreateBooklists < ActiveRecord::Migration[5.0]
  def change
    create_table :booklists do |t|
      t.references :user, foreign_key: true, index: true
      t.references :book, foreign_key: true, index: true

      t.timestamps
    end
  end
end
