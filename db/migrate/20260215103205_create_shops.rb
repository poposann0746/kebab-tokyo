class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lng
      t.string :image_url1
      t.string :image_url2
      t.string :image_url3

      t.timestamps
    end
  end
end
