class IngredientsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @ingredient = @post.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to @post, notice: '材料を追加しました'
    else
      render 'post/show', alert: '材料の追加に失敗しました'
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :ingredient_id, :quantity, :is_shopping_list)
  end
end
