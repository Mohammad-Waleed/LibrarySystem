class CreateBook < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title        ,null: false
      t.string :isbn         ,null: false
      t.string :author       ,null: false
      t.integer :year        ,null: false
      t.string :genre        ,null: false
      t.integer :no_of_copies,null: false,default: 0
      t.integer :status      ,null: false,default: 0
      t.references :library
    end
  end
end
