class CreateLibrary < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.numeric :fine, null: false, default: 0

      t.timestamps null: false
    end
  end
end
