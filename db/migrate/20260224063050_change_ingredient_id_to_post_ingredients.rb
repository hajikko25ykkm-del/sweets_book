class ChangeIngredientIdToPostIngredients < ActiveRecord::Migration[6.1]
  def change
    change_column_null :post_ingredients, :ingredient_id, true
  end
end
