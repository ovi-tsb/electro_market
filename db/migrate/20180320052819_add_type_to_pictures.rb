class AddTypeToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :type, :string
  end
end
