class CreateBookHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :book_histories do |t|
      t.references :book, null: false
      t.references :issuer, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
