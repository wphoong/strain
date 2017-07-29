class AddHasStoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_store?, :boolean, default: false
  end
end
