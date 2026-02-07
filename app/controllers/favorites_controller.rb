class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    # ボタンを押した元のページ（詳細ページや一覧など）にリロードして戻す
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @favorite_posts = current_user.favorite_posts
  end

end
