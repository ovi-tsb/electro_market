class RemoveIntegerFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :integer, :string
  end
end
