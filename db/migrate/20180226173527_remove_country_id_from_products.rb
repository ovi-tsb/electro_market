class RemoveCountryIdFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :country_id, :string
  end
end
