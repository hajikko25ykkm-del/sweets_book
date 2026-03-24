class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
    @shopping_list.shopping_list_items.where(is_bought: true).destroy_all
    all_items = @shopping_list.shopping_list_items.includes(post_ingredient: :post)
    @items_by_post = all_items.select { |item| item.post_ingredient&.post }.group_by { |item| item.post_ingredient.post }
  end

  def add_item
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
    @pi = PostIngredient.find(params[:post_ingredient_id])
    @item = @shopping_list.shopping_list_items.find_or_initialize_by(post_ingredient_id: @pi.id)

    @item.save
  end

  def update
    @shopping_list = current_user.shopping_list
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_path, notice: "メモを保存しました"
    else
      render :show
    end
  end

  def update_item_status
    @item = ShoppingListItem.find(params[:id])
    @item.update(is_bought: !@item.is_bought)
  end

  def destroy_item
    @item = ShoppingListItem.find(params[:id])
    @item.destroy
    
    respond_to do |format|
      format.js # destroy_item.js.erb を実行
      format.html { redirect_to shopping_list_path }
    end
  end

  private

  def shopping_list_params
    params.require(:shopping_list).permit(:content)
  end

end