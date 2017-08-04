class AlterProductsAddUserId < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :user_id, :integer
    add_column :products, :store_id, :integer
    add_index :products, [:user_id, :store_id]
    add_index :products, :store_id
  end
end
