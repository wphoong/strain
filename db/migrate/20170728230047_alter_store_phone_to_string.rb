class AlterStorePhoneToString < ActiveRecord::Migration[5.1]
  def change
    remove_column :stores, :phone, :integer
    add_column :stores, :phonenumber, :string
  end
end
