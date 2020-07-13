class CreateBook < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, null: false, default: ''
      t.string :isbn, null: false, limit: 13, default: ''
      t.string :author, null: false, limit: 40, default: ''
      t.integer :year, null: false, default: 2020
      t.string :genre, null: false, limit: 50, default: ''
      t.integer :no_of_copies, null: false, default: 0
      t.integer :status, null: false, default: 'unavailable'
      t.references :library

      t.timestamps null: false
    end
  end
end
