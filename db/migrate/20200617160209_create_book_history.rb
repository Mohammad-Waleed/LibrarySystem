class CreateBookHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :book_histories do |t|
      t.references :book      ,null: false
      t.references :issuer    ,null: false
      t.string :start_date
      t.string :end_date
    end
  end
end
