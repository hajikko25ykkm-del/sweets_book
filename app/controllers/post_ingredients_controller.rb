class PostIngredientsController < ApplicationController
  before_action :authenticate_user!
  def update_shopping_list
    @post_ingredient = PostIngredient.find(params[:id])
    @post_ingredient.update(is_shopping_list: !@post_ingredient.is_shopping_list)
    head :nocontent
  end
end
