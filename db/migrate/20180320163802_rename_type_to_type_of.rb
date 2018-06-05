class RenameTypeToTypeOf < ActiveRecord::Migration[5.1]
  def change
    rename_column :pictures, :type, :type_of
  end
end
