class AddInfoToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :strain, :string
    add_column :products, :type, :string
    add_column :products, :description, :string
    add_column :products, :effects, :string
  end
end
