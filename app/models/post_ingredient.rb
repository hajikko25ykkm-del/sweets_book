class PostIngredient < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :ingredient, optional: true
  has_many :shopping_list_items, dependent: :destroy

  attr_accessor :ingredient_name
  before_validation :set_ingredient_by_name

  # after_save :sync_shopping_list_item

  def ingredient_name
    @ingredient_name || ingredient&.name
  end

  private

  def sync_shopping_list_item
    return unless post&.user
    user = post.user
    shopping_list = user.shopping_list || user.create_shopping_list

    if is_shopping_list
      shopping_list.shhopping_list_items.find_or_create_by!(post_ingredient_id: self.id)
    else
      shopping_list.shopping_list_items.find_by(post_ingredient_id: self.id)&.destroy
    end
  end

  def set_ingredient_by_name
    if ingredient_name.present?
      self.ingredient = Ingredient.find_or_create_by(name: ingredient_name)
    end
  end

  def set_ingredient_name_from_db
    self.ingredient_name ||= ingredient&.name
  end
end