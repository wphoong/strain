class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :storename
      t.text :description
      t.string :location
      t.integer :phone
      t.integer :user_id
      t.timestamps
    end
    add_index :stores, :user_id
  end
end
