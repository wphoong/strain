class AlterHasStoreForUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :has_store?, :boolean
    add_column :users, :has_store, :boolean, default: false
  end
end
