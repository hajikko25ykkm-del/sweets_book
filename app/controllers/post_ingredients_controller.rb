class PostIngredientsController < ApplicationController
  before_action :authenticate_user!

  def update_shopping_list
    @post_ingredient = PostIngredient.find(params[:id])
    
    new_status = !@post_ingredient.is_shopping_list
    if @post_ingredient.update(is_shopping_list: new_status)
      
      shopping_list = current_user.shopping_list || current_user.create_shopping_list

      if new_status
        shopping_list.shopping_list_items.find_or_create_by!(post_ingredient_id: @post_ingredient.id)
      else
        shopping_list.shopping_list_items.find_by(post_ingredient_id: @post_ingredient.id)&.destroy
      end

      head :no_content
    else
      render json: @post_ingredient.errors, status: :unprocessable_entity
    end
  end

end
