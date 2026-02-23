class PostIngredient < ApplicationRecord
  belongs_to :post
  belongs_to :ingredient

  attr_accessor :ingredient_name
  before_validation :set_ingredient_from_name

  private
  def set_ingredient_from_name
    if ingredient_name.present?
      self.ingredient = Ingredient.find_or_create_by(name: ingredient_name)
    end
  end
end
