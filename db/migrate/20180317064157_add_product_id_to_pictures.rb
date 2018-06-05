class AddProductIdToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :product_id, :integer
  end
end
