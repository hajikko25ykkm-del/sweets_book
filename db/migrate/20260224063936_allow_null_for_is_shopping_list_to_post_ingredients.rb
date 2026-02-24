class AllowNullForIsShoppingListToPostIngredients < ActiveRecord::Migration[6.1]
  def change
    change_column_null :post_ingredients, :is_shopping_list, true
  end
end
