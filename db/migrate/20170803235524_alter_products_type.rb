class AlterProductsType < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :type, :string
    add_column :products, :straintype, :string
  end
end
