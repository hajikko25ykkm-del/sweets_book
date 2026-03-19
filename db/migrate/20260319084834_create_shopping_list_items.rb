class CreateShoppingListItems < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_list_items do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.references :post_ingredient, null: false, foreign_key: true
      t.boolean :is_bought, default: false

      t.timestamps
    end
  end
end
