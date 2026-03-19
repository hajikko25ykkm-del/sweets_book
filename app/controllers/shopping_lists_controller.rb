class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @shopping_list = current_user.shopping_list || current_user.create_shopping_list
    all_items = @shopping_list.shopping_list_items.includes(post_ingredient: :post)
    @items_by_post = all_items.select { |item| item.post_ingredient&.post }.group_by { |item| item.post_ingredient.post }
  end

  def add_item
    @shopping_list = crrent_user.shopping_list || current_user.create_shopping_list
    @item = @shopping_list.shopping_list_items.find_or_initialize_by(post_ingredient_id: params[:post_ingredient_id])

    if @item.save
      redirect_back(fallback_location: root_path, notice: "材料をリストに追加しました！")
    else
      redirect_back(fallback_location: root_path, alert: "追加に失敗しました。")
    end
  end

  def update
    @shopping_list = current_user.shopping_list
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_path, notice: "メモを保存しました"
    else
      render :show
    end
  end

  def destroy_item
    @item = current_user.shopping_list.shopping_list_items.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def shopping_list_params
    params.require(:shopping_list).permit(:content)
  end

end