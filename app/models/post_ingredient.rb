class PostIngredient < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :ingredient, optional: true

  attr_accessor :ingredient_name
  before_validation :set_ingredient_from_name

  private
  def set_ingredient_from_name
    if ingredient_name.present?
      found_ingredient = Ingredient.find_or_create_by(name: ingredient_name)
      self.ingredient = found_ingredient
      self.ingredient_id = found_ingredient.id
    end
  end
end
