class AddAreaToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :area, :string
    add_index :shops, :area
  end
end
