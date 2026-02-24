class PostIngredient < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :ingredient, optional: true

  attr_accessor :ingredient_name
  before_validation :set_ingredient_by_name

  def ingredient_name
    @ingredient_name || ingredient&.name
  end

  private

  def set_ingredient_by_name
    if ingredient_name.present?
      self.ingredient = Ingredient.find_or_create_by(name: ingredient_name)
    end
  end

  def set_ingredient_name_from_db
    self.ingredient_name ||= ingredient&.name
  end
end