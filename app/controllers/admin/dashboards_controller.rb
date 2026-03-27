class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user_count = User.count
    @post_count = Post.count
    @posts = Post.includes(:user).order(created_at: :desc).limit(5)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました。"
  end
end
