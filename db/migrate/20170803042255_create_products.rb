class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :strain
      t.string :type
      t.text :description
      t.text :effects
      t.integer :user_id
      t.intger :store_id
      t.timestamps
    end
    add_index :products, [:user_id, :store_id]
    add_index :product, :store_id
  end
end
