class RemoveStringColumnFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :string, :string
  end
end
