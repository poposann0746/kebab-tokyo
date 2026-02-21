class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, null: false, foreign_key: true
      t.references :shop, null: false, null: false, foreign_key: true
      t.integer :category
      t.integer :meat_type
      t.integer :sauce_type
      t.integer :meat_taste
      t.integer :sauce_taste
      t.integer :vegetable_amount
      t.integer :bread_compatibility
      t.integer :value_for_money
      t.integer :overall_score, null: false
      t.text :comment

      t.timestamps
    end
  end
end
