class Admin::DashboardsController < Admin::ApplicationController
  def index
    @user_count = User.count
    @post_count = Post.count
    @posts = Post.includes(:user).order(created_at: :desc).limit(5)
  end
end
