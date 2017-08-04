class AlterProductsInput < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :description, :string
    remove_column :products, :effects, :string
    add_column :products, :description, :text
    add_column :products, :effects, :text
  end
end
