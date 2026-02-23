class CreatePostIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :post_ingredients do |t|
      t.references :post, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.string :quantity
      t.boolean :is_shopping_list, default: false, null: false

      t.timestamps
    end
  end
end
