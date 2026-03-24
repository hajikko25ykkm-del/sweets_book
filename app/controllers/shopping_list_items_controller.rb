class ShoppingListItemsController < ApplicationController
  def destroy
    @item = ShoppingListItem.find(params[:id])
    @pi = @item.post_ingredient
    @item.destroy
  end
end
