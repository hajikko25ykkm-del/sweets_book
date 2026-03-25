class Admin::CommentsController < Admin::ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_post_path(params[:post_id]), notice: 'コメントを削除しました' }
      format.js
    end
  end
end